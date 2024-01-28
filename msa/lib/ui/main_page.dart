import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../api_client/api_client.dart';
import '../constants/colors.dart';
import '../models/labels_model.dart';
import '../models/link_features.dart';
import '../models/links_model.dart';
import 'screens/external_site.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // late WebViewController bardWebViewController;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int selectedIndex = 0;
  int currentIndex = 0;
  ValueNotifier<int> tabResetDeterminant = ValueNotifier<int>(0);

  // Home page . . .
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  bool checkedServer = false;
  bool gotLabels = false;
  List<LabelModel> labels = [];
  List<LinkModel> links = [];
  List<Widget> w = [];
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  bool otherTabs = false;
  bool scrolled = true;
  late TabController tc;

  ScrollController scrollController = ScrollController();
  double previousScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(scrollListener);
    getConnectivity();
    /* bardWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate())
      ..loadRequest(Uri.parse('https://bard.google.com')); */
  }

  // void scrollListener() {
  //   // Handle scrolling actions here
  //   double currentScrollPosition = scrollController.position.pixels;
  //   if (currentScrollPosition > previousScrollPosition) {
  //     // Scrolling down
  //     print("Scrolling down");
  //     setState(() {
  //       scrolled = true;
  //     });
  //   } else {
  //     // Scrolling up
  //     print("Scrolling up");
  //     setState(() {
  //       scrolled = false;
  //     });
  //   }

  //   // Update the previous scroll position
  //   previousScrollPosition = currentScrollPosition;
  // }

  @override
  void dispose() {
    subscription.cancel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          // sometimes the stream builder doesn't work with simulator so you can check this on real devices to get the right result

          if (snapshot.hasData) {
            ConnectivityResult? result = snapshot.data;
            if (result == ConnectivityResult.mobile ||
                result == ConnectivityResult.wifi) {
              return WillPopScope(
                  onWillPop: () async {
                    return true;
                  },
                  child: frameItems()[selectedIndex]);
            } else {
              return noInternet();
            }
          } else {
            return loading();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 39, 39, 39),
        selectedItemColor: Colors.green,
        selectedIconTheme: const IconThemeData(color: Colors.green),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          // if (selectedIndex == 0 && currentIndex == 0) {
          //   setState(() {
          //     tc.animateTo(0);
          //     // scrolled = false;
          //   });
          // } else {
          setState(() {
            selectedIndex = value;
            currentIndex = selectedIndex;
          });
        },
        // },
        items: [
          const BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded),
          ),
          const BottomNavigationBarItem(
            label: 'Stats',
            icon: Icon(Icons.signal_cellular_alt),
          ),
          BottomNavigationBarItem(
            label: 'Ask AI',
            icon: Image.asset(
              "assets/icons/chatbot.png",
              width: 25,
              height: 25,
              color: Colors.black,
            ),
            activeIcon: Image.asset(
              "assets/icons/chatbot.png",
              width: 25,
              height: 25,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> frameItems() {
    return [
      home(),
      const Center(
        child: Text('Stats'),
      ),
      Container()
      /* Center(
        child: SafeArea(
          child: Expanded(
            child: WebViewWidget(
              controller: bardWebViewController,
            ),
          ),
        ),
      ), */
    ];
  }

  home() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          otherTabs ? Container() : header(context),
          otherTabs
              ? Container()
              : scrolled
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mediaIcons(
                              'Google',
                              Image.asset("assets/icons/google.png"),
                              'https://google.com'),
                          mediaIcons(
                              'Youtube',
                              Image.asset("assets/icons/yt.png"),
                              'https://www.youtube.com/'),
                          mediaIcons(
                              'Facebook',
                              Image.asset("assets/icons/facebook.png"),
                              'https://www.facebook.com/'),
                          mediaIcons(
                              'Instagram',
                              Image.asset("assets/icons/insta.png"),
                              'https://www.instagram.com/'),
                          mediaIcons(
                              'Twitter',
                              Image.asset("assets/icons/twitter.png"),
                              'https://www.twitter.com/'),
                        ],
                      ),
                    ),
          Container(height: 0.5, color: Colors.grey, width: double.maxFinite),
          !gotLabels
              ? Container()
              : SizedBox(
                  height: 40,
                  child: TabBar(
                      indicatorWeight: 3,
                      indicatorColor: appColor,
                      isScrollable: true,
                      controller: tc,
                      tabs: categoriesTabs())),
          Container(height: 0.5, color: Colors.grey, width: double.maxFinite),
          !checkedServer || !gotLabels
              ? Container()
              : Expanded(child: TabBarView(controller: tc, children: cats())),
        ],
      ),
    );
  }

// Home functions . . .
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected) {
            setState(() {
              isAlertSet = true;
            });
          } else {
            getLabels();
            getLinks();
          }
        },
      );

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  Widget noInternet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*  Image.asset(
          'assets/images/no_internet.png',
          color: Colors.red,
          height: 100,
        ), */
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            "No Internet connection",
            style: TextStyle(fontSize: 22),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text("Check your connection, then refresh the page."),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () async {
            // You can also check the internet connection through this below function as well
            ConnectivityResult result =
                await Connectivity().checkConnectivity();
            print(result.toString());
          },
          child: const Text("Refresh"),
        ),
      ],
    );
  }

  categoriesTabs() {
    List<Tab> t = [
      Tab(
          child: Text(
        "For You",
        style: tc.index == 0 ? bold : light,
      ))
    ];
    for (int i = 1; i < labels.length; i++) {
      t.add(Tab(child: Text(labels[i].labelName, style: light)));
    }
    return t;
  }

  List<Widget> cats() {
    List<Widget> cs = [foryou()];

    for (int i = 1; i < labels.length; i++) {
      cs.add(SingleChildScrollView(
        child: Column(
          children: [
            i < 4 || i == labels.length - 1
                ? Container()
                : Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration: BoxDecoration(color: teamColor(i)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imageName(i).contains(".")
                            ? Image.asset(
                                imageName(i),
                                height: 150,
                                fit: BoxFit.fitHeight,
                              )
                            : Container(),
                        Text(
                          labels[i].labelName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
            Column(
              children: w,
            )
          ],
        ),
      ));
    }
    return cs;
  }

  String imageName(int i) {
    String n = "assets/team_logos/";
    switch (i) {
      case 4:
        n += "alnasar.png";
        break;
      case 5:
        n += "arsenal.png";
        break;
      case 6:
        n += "athletico.png";
        break;
      case 7:
        n += "barcelona.png";
        break;
      case 8:
        n += "bayern.png";
        break;
      case 9:
        n += "chelsea.png";
        break;
      case 10:
        n += "everton.png";
        break;
      case 11:
        n += "intermiami.png";
        break;
      case 12:
        n += "juventus.png";
        break;
      case 13:
        n += "liverpool.png";
        break;
      case 14:
        n += "mancity.png";
        break;
      case 15:
        n += "manu.png";
        break;
      case 16:
        n += "napoli.png";
        break;
      case 17:
        n += "psg.png";
        break;
      case 18:
        n += "realmadrid.png";
        break;
      case 19:
        n += "tottenham.png";
        break;
      default:
        n += "";
        break;
    }
    return n;
  }

  Color? teamColor(int i) {
    Color? c = Colors.red;
    switch (i) {
      case 4:
        c = Colors.yellow;
        break;
      case 5:
        c = Colors.red;
        break;
      case 6:
        c = Colors.red;
        break;
      case 7:
        c = Colors.red;
        break;
      case 8:
        c = Colors.blue;
        break;
      case 9:
        c = Colors.blue;
        break;
      case 10:
        c = Colors.blue;
        break;
      case 11:
        c = Colors.blue;
        break;
      case 12:
        c = Colors.blue;
        break;
      case 13:
        c = Colors.red;
        break;
      case 14:
        c = Colors.blue;
        break;
      case 15:
        c = Colors.red;
        break;
      case 16:
        c = Colors.blue;
        break;
      case 17:
        c = Colors.blue;
        break;
      case 18:
        c = Colors.blue;
        break;
      case 19:
        c = Colors.blue;
        break;
      default:
        c = Colors.white;
        break;
    }
    return c;
  }

  Widget foryou() {
    return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            /* Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.fireplace_rounded),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Trending News",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          height: 250,
          child: topStoriesListView(),
        ),
        const SizedBox(
          height: 20,
        ), */
            Column(
              children: newsList(""),
            )
          ],
        ));
  }

  Widget topStoriesListView() {
    List<Widget> topStoriesWidgets = [];
    // for (int i = 0; i < links.length; i++) {
    for (int i = 0; i < 5; i++) {
      if (links[i].labels.contains(labels[3].labelName)) {
        topStoriesWidgets.add(topStories(links[i], context));
      }
    }
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topStoriesWidgets.length,
        itemBuilder: (context, index) => topStoriesWidgets[index]);
  }

  List<Widget> newsList(String label) {
    List<Widget> t = [];
    if (label.isEmpty) {
      for (int i = 0; i < links.length; i++) {
        // for (int i = 0; i < 5; i++) {
        t.add(news(context, links[i]));
      }
    } else {
      for (int i = 0; i < links.length; i++) {
        // for (int i = 0; i < 5; i++) {
        if (links[i].labels.contains(label)) {
          t.add(news(context, links[i]));
        }
      }
    }

    return t;
  }

  Widget categories(WebViewController wController) {
    return WebViewWidget(
      controller: wController,
    );
  }

  Widget mediaIcons(String name, Image image, String url) {
    return InkWell(
      onTap: () {
        /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Browse(
                url: url,
              ),
            )); */
      },
      child: Column(
        children: [
          CircleAvatar(radius: 16, backgroundColor: Colors.white, child: image),
          const SizedBox(
            height: 6,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      color: appColor,
      padding: const EdgeInsets.only(left: 14, top: 2, bottom: 4, right: 0),
      child: Row(children: [
        Expanded(
          child: Container(
            height: 30,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Browse(
                          search: true,
                        ),
                      )); */
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          'assets/icons/google.png',
                          height: 25,
                          width: 25,
                        )),
                    const SizedBox(
                      width: 6,
                    ),
                    const Expanded(
                        child: Text(
                      'Search url or web adress',
                      style: TextStyle(fontSize: 14),
                    )),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 65, 64, 64),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      margin: const EdgeInsets.only(right: 4),
                      child: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 17,
        ),
        /* InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Tabs())),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255), width: 2),
                borderRadius: BorderRadius.circular(7),
                color: Colors.white),
            height: 24,
            width: 24,
            child: const Center(
              child: Text('4'),
            ),
          ),
        ), */
        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          color: Colors.white,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                value: 'a',
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      InkWell(
                          onTap: () async {
                            /*  if (await webViewController.canGoBack()) {
                              Navigator.pop(context);
                              webViewController.goBack();
                            } */
                          },
                          child: const Icon(Icons.arrow_back)),
                      InkWell(
                          onTap: () async {
                            /* if (await webViewController.canGoForward()) {
                              Navigator.pop(context);
                              webViewController.goForward();
                            } */
                          },
                          child: const Icon(Icons.arrow_forward)),
                      const Icon(Icons.star_outline),
                      const Icon(Icons.download),
                      const Icon(Icons.clear),
                      const SizedBox(),
                    ],
                  ),
                ),
              ),
              /* PopupMenuItem(
                value: 'b',
                child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Tabs())),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.add_box_outlined),
                              SizedBox(
                                width: 12,
                              ),
                              Text('New tab')
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            height: 1,
                            width: double.maxFinite,
                            color: Colors.grey[300],
                          )
                        ],
                      )),
                ),
              ), */
              /* PopupMenuItem(
                child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const History())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.history),
                        SizedBox(
                          width: 12,
                        ),
                        Text('History')
                      ],
                    ),
                  ),
                ),
              ), */
              /* PopupMenuItem(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Downloads())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.download_done),
                        SizedBox(
                          width: 12,
                        ),
                        Text('Downloads')
                      ],
                    ),
                  ),
                ),
              ), */
              PopupMenuItem(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Row(
                        children: [
                          Icon(Icons.star),
                          SizedBox(
                            width: 12,
                          ),
                          Text('Bookmarks')
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 1,
                      width: double.maxFinite,
                      color: Colors.grey[300],
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Share...')
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.tv),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('Desktop site'),
                          Expanded(child: Container()),
                          const Icon(Icons.check_box_outline_blank_rounded)
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 1,
                      width: double.maxFinite,
                      color: Colors.grey[300],
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Settings')
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.help_outline),
                      SizedBox(
                        width: 12,
                      ),
                      Text('About')
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Exit')
                    ],
                  ),
                ),
              ),
            ];
          },
        ),
      ]),
    );
  }

  Widget addsBlock() {
    return Container(
      width: double.maxFinite,
      height: 250,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
      child: const Center(
        child: Text(
          "300x250 Adds",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget news(BuildContext context, LinkModel link) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExternalSite(url: link.url)));
        },
        child: FutureBuilder<LinkFeatures?>(
          future: getLinkFeatures(link.url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Use the data to build your UI
              LinkFeatures linkFeatures = snapshot.data!;
              return Container(
                /* decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))), */
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 80,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 2.0)
                          ]),
                      child: Image.network(
                        linkFeatures.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        linkFeatures.title,
                        style: GoogleFonts.oswald(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('No data available.');
            }
          },
        ));
  }

  Widget topStories(LinkModel link, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExternalSite(url: link.url)));
        },
        child: FutureBuilder<LinkFeatures?>(
          future: getLinkFeatures(link.url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Use the data to build your UI
              LinkFeatures linkFeatures = snapshot.data!;
              return Container(
                height: double.maxFinite,
                margin: const EdgeInsets.only(left: 18, bottom: 10, top: 10),
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 2.0)
                    ]),
                child: Column(
                  children: [
                    Expanded(
                        child: SizedBox(
                            width: double.maxFinite,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.network(
                                linkFeatures.image,
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Container(
                      height: 70,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.8, // Adjust the border width as needed
                            color: Colors.grey, // Specify the border color
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      child: Center(
                          child: Text(
                        linkFeatures.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.fade,
                      )),
                    )
                  ],
                ),
              );
            } else {
              return const Text('No data available.');
            }
          },
        ));
  }

  String extractFeatureImage(String htmlContent) {
    var document = parse(htmlContent);
    var imageElement = document.querySelector('meta[property="og:image"]');
    return imageElement?.attributes['content'] ??
        ''; // Return the image URL or an empty string if not found.
  }

  Future<LinkFeatures?> getLinkFeatures(String link) async {
    try {
      String htmlContent = await fetchHTMLContent(link);
      LinkFeatures linkFeatures = LinkFeatures(
          extractTitle(htmlContent), extractFeatureImage(htmlContent), link);
      return linkFeatures;
    } catch (e) {
      // Log the exception and return null.
      print('Error fetching link features: $e');
      return null;
    }
  }

  String extractTitle(String htmlContent) {
    var document = parse(htmlContent);
    var titleElement = document.querySelector('title');
    return titleElement?.text ??
        ''; // Return the title or an empty string if not found.
  }

  Future<String> fetchHTMLContent(String link) async {
    final response = await http.get(Uri.parse(link));
    return response.body;
  }

  void getLinks() async {
    var linksData = await ApiClient.free().getLinks();
    for (var data in linksData) {
      links.add(LinkModel.fromJson(data));
    }
    setState(() {
      links = links.reversed.toList();
      checkedServer = true;
    });
  }

  void getLabels() async {
    var labelsData = await ApiClient.free().getLabels();
    for (var data in labelsData) {
      labels.add(LabelModel.fromJson(data));
    }
    tc = TabController(length: labels.length, vsync: this);
    // tc.addListener(_onTabChanged);

    setState(() {
      gotLabels = true;
    });
  }
//
}
