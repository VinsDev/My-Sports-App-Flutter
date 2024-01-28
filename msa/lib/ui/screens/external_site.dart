import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/colors.dart';

class ExternalSite extends StatefulWidget {
  const ExternalSite({super.key, this.url});
  final String? url;
  @override
  State<ExternalSite> createState() => _ExternalSiteState();
}

List<Widget> comments = [
  commentBlock(
      "Hello pls this is a comment. You can also try by commenting and seeing the effect . . .")
];

class _ExternalSiteState extends State<ExternalSite> {
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();

  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        /*  onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        }, */
      ),
    )
    ..loadRequest(Uri.parse('https://google.com'));

  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent * 1.15,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    webViewController.loadRequest(Uri.parse((widget.url ?? '').isEmpty
        ? 'https://google.com'
        : widget.url.toString()));
  }

  Future<bool> _onBack() async {
    bool goBack = false;
    var value = await webViewController.canGoBack();
    if (value) {
      webViewController.goBack();
      return false;
    } else {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Confirmation"),
                content: Text("Do you want to exit the post ?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        setState(() {
                          goBack = false;
                        });
                      },
                      child: Text("No")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        setState(() {
                          goBack = true;
                        });
                      },
                      child: Text("Yes"))
                ],
              ));
      if (goBack) Navigator.pop(context);
      return goBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "My Football News",
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
            backgroundColor: appColor,
            elevation: 0,
          ),
          body: Column(children: [
            Expanded(
              child: WebViewWidget(
                controller: webViewController,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade200),
                    child: Row(children: [
                      const Icon(Icons.edit),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (txt) {
                            setState(() {});
                          },
                          controller: commentController,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Add a comment"),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                commentController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            comments.add(commentBlock(commentController.text));
                            commentController.text = "";
                          });
                          scrollToBottom();
                        },
                        child: const Icon(Icons.send))
                    : const SizedBox(),
                const SizedBox(
                  width: 90,
                )
              ],
            )
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _shareContent(context);
            },
            tooltip: 'Share',
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset("assets/icons/share.jpeg")),
          ),
        ),
      ),
    );
  }
}

void _shareContent(BuildContext context) {
  Share.share('Check out this amazing content!');
}

commentBlock(String comment) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 16,
              child: Center(
                  child: Text(
                "V",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )),
            ),
            const SizedBox(
              width: 15,
            ),
            const Text(
              "Vincent Dominic",
              style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontWeight: FontWeight.w600),
            ),
            Expanded(child: Container()),
            const Icon(
              Icons.thumb_up_sharp,
              size: 20,
            ),
            const SizedBox(
              width: 2,
            ),
            const Text(
              "11",
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.thumb_down,
              size: 20,
            ),
            const SizedBox(
              width: 2,
            ),
            const Text(
              "2",
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Text(
          comment,
          style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 48, 48, 48),
              fontWeight: FontWeight.w400),
        ),
      ),
      const SizedBox(
        height: 6,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 8),
        child: Row(
          children: [
            const Text(
              "Reply",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(child: Container()),
            const Icon(
              Icons.more_vert_rounded,
              size: 20,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 6,
      ),
    ],
  );
}
