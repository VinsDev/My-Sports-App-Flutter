class Post {
  int id;
  String date;
  String dateGmt;
  Guid guid;
  String modified;
  String modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Title title;
  Content content;
  Excerpt excerpt;
  int author;
  int featuredMedia;
  String commentStatus;
  String pingStatus;
  bool sticky;
  String template;
  String format;
  Meta meta;
  List<int> categories;
  List<int> tags;
  String yoastHead;
  YoastHeadJson yoastHeadJson;
  String jetpackFeaturedMediaUrl;
  Links links;

  Post({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.commentStatus,
    required this.pingStatus,
    required this.sticky,
    required this.template,
    required this.format,
    required this.meta,
    required this.categories,
    required this.tags,
    required this.yoastHead,
    required this.yoastHeadJson,
    required this.jetpackFeaturedMediaUrl,
    required this.links,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      date: json['date'],
      dateGmt: json['date_gmt'],
      guid: Guid.fromJson(json['guid']),
      modified: json['modified'],
      modifiedGmt: json['modified_gmt'],
      slug: json['slug'],
      status: json['status'],
      type: json['type'],
      link: json['link'],
      title: Title.fromJson(json['title']),
      content: Content.fromJson(json['content']),
      excerpt: Excerpt.fromJson(json['excerpt']),
      author: json['author'],
      featuredMedia: json['featured_media'],
      commentStatus: json['comment_status'],
      pingStatus: json['ping_status'],
      sticky: json['sticky'],
      template: json['template'],
      format: json['format'],
      meta: Meta.fromJson(json['meta']),
      categories: List<int>.from(json['categories']),
      tags: List<int>.from(json['tags']),
      yoastHead: json['yoast_head'],
      yoastHeadJson: YoastHeadJson.fromJson(json['yoast_head_json']),
      jetpackFeaturedMediaUrl: json['jetpack_featured_media_url'],
      links: Links.fromJson(json['_links']),
    );
  }
}

class Guid {
  String rendered;

  Guid({required this.rendered});

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(
      rendered: json['rendered'],
    );
  }
}

class Title {
  String rendered;

  Title({required this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      rendered: json['rendered'],
    );
  }
}

class Content {
  String rendered;
  bool protected;

  Content({required this.rendered, required this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json['rendered'],
      protected: json['protected'],
    );
  }
}

class Excerpt {
  String rendered;
  bool protected;

  Excerpt({required this.rendered, required this.protected});

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(
      rendered: json['rendered'],
      protected: json['protected'],
    );
  }
}

class Meta {
  String footnotes;

  Meta({required this.footnotes});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      footnotes: json['footnotes'],
    );
  }
}

class YoastHeadJson {
  String title;
  Map<String, dynamic> robots;
  String canonical;
  String ogLocale;
  String ogType;
  String ogTitle;
  String ogDescription;
  String ogUrl;
  String ogSiteName;
  String articlePublishedTime;
  String articleModifiedTime;
  List<MetaImage> ogImage;
  String author;
  String twitterCard;
  Map<String, dynamic> twitterMisc;
  Schema schema;

  YoastHeadJson({
    required this.title,
    required this.robots,
    required this.canonical,
    required this.ogLocale,
    required this.ogType,
    required this.ogTitle,
    required this.ogDescription,
    required this.ogUrl,
    required this.ogSiteName,
    required this.articlePublishedTime,
    required this.articleModifiedTime,
    required this.ogImage,
    required this.author,
    required this.twitterCard,
    required this.twitterMisc,
    required this.schema,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) {
    return YoastHeadJson(
      title: json['title'],
      robots: Map<String, dynamic>.from(json['robots']),
      canonical: json['canonical'],
      ogLocale: json['og_locale'],
      ogType: json['og_type'],
      ogTitle: json['og_title'],
      ogDescription: json['og_description'],
      ogUrl: json['og_url'],
      ogSiteName: json['og_site_name'],
      articlePublishedTime: json['article_published_time'],
      articleModifiedTime: json['article_modified_time'],
      ogImage: List<MetaImage>.from(
          json['og_image'].map((x) => MetaImage.fromJson(x))),
      author: json['author'],
      twitterCard: json['twitter_card'],
      twitterMisc: Map<String, dynamic>.from(json['twitter_misc']),
      schema: Schema.fromJson(json['schema']),
    );
  }
}

class MetaImage {
  int width;
  int height;
  String url;
  String type;

  MetaImage({
    required this.width,
    required this.height,
    required this.url,
    required this.type,
  });

  factory MetaImage.fromJson(Map<String, dynamic> json) {
    return MetaImage(
      width: json['width'],
      height: json['height'],
      url: json['url'],
      type: json['type'],
    );
  }
}

class Schema {
  String context;
  List<Graph> graph;

  Schema({
    required this.context,
    required this.graph,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      context: json['@context'],
      graph: List<Graph>.from(json['@graph'].map((x) => Graph.fromJson(x))),
    );
  }
}

class Graph {
  String type;
  String id;
  String url;
  String name;
  IsPartOf isPartOf;
  String datePublished;
  String dateModified;
  Author author;
  Breadcrumb breadcrumb;
  String inLanguage;
  List<PotentialAction> potentialAction;

  Graph({
    required this.type,
    required this.id,
    required this.url,
    required this.name,
    required this.isPartOf,
    required this.datePublished,
    required this.dateModified,
    required this.author,
    required this.breadcrumb,
    required this.inLanguage,
    required this.potentialAction,
  });

  factory Graph.fromJson(Map<String, dynamic> json) {
    return Graph(
      type: json['@type'],
      id: json['@id'],
      url: json['url'],
      name: json['name'],
      isPartOf: IsPartOf.fromJson(json['isPartOf']),
      datePublished: json['datePublished'],
      dateModified: json['dateModified'],
      author: Author.fromJson(json['author']),
      breadcrumb: Breadcrumb.fromJson(json['breadcrumb']),
      inLanguage: json['inLanguage'],
      potentialAction: List<PotentialAction>.from(
          json['potentialAction'].map((x) => PotentialAction.fromJson(x))),
    );
  }
}

class Author {
  String id;

  Author({required this.id});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['@id'],
    );
  }
}

class Breadcrumb {
  String id;

  Breadcrumb({required this.id});

  factory Breadcrumb.fromJson(Map<String, dynamic> json) {
    return Breadcrumb(
      id: json['@id'],
    );
  }
}

class IsPartOf {
  String id;

  IsPartOf({required this.id});

  factory IsPartOf.fromJson(Map<String, dynamic> json) {
    return IsPartOf(
      id: json['@id'],
    );
  }
}

class PotentialAction {
  String type;
  List<String> target;

  PotentialAction({
    required this.type,
    required this.target,
  });

  factory PotentialAction.fromJson(Map<String, dynamic> json) {
    return PotentialAction(
      type: json['@type'],
      target: List<String>.from(json['target']),
    );
  }
}

class Links {
  List<Self> self;
  List<Collection> collection;
  List<About> about;
  List<Author> author;
  List<Replies> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<WpFeaturedmedia> wpFeaturedmedia;
  List<WpAttachment> wpAttachment;
  List<WpTerm> wpTerm;
  List<Curies> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
    required this.versionHistory,
    required this.predecessorVersion,
    required this.wpFeaturedmedia,
    required this.wpAttachment,
    required this.wpTerm,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: List<Self>.from(json['self'].map((x) => Self.fromJson(x))),
      collection: List<Collection>.from(
          json['collection'].map((x) => Collection.fromJson(x))),
      about: List<About>.from(json['about'].map((x) => About.fromJson(x))),
      author: List<Author>.from(json['author'].map((x) => Author.fromJson(x))),
      replies:
          List<Replies>.from(json['replies'].map((x) => Replies.fromJson(x))),
      versionHistory: List<VersionHistory>.from(
          json['version-history'].map((x) => VersionHistory.fromJson(x))),
      predecessorVersion: List<PredecessorVersion>.from(
          json['predecessor-version']
              .map((x) => PredecessorVersion.fromJson(x))),
      wpFeaturedmedia: List<WpFeaturedmedia>.from(
          json['wp:featuredmedia'].map((x) => WpFeaturedmedia.fromJson(x))),
      wpAttachment: List<WpAttachment>.from(
          json['wp:attachment'].map((x) => WpAttachment.fromJson(x))),
      wpTerm: List<WpTerm>.from(json['wp:term'].map((x) => WpTerm.fromJson(x))),
      curies: List<Curies>.from(json['curies'].map((x) => Curies.fromJson(x))),
    );
  }
}

class Self {
  String href;

  Self({required this.href});

  factory Self.fromJson(Map<String, dynamic> json) {
    return Self(
      href: json['href'],
    );
  }
}

class Collection {
  String href;

  Collection({required this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      href: json['href'],
    );
  }
}

class About {
  String href;

  About({required this.href});

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      href: json['href'],
    );
  }
}

class Replies {
  bool embeddable;
  String href;

  Replies({required this.embeddable, required this.href});

  factory Replies.fromJson(Map<String, dynamic> json) {
    return Replies(
      embeddable: json['embeddable'],
      href: json['href'],
    );
  }
}

class VersionHistory {
  int count;
  String href;

  VersionHistory({required this.count, required this.href});

  factory VersionHistory.fromJson(Map<String, dynamic> json) {
    return VersionHistory(
      count: json['count'],
      href: json['href'],
    );
  }
}

class PredecessorVersion {
  int id;
  String href;

  PredecessorVersion({required this.id, required this.href});

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) {
    return PredecessorVersion(
      id: json['id'],
      href: json['href'],
    );
  }
}

class WpFeaturedmedia {
  bool embeddable;
  String href;

  WpFeaturedmedia({required this.embeddable, required this.href});

  factory WpFeaturedmedia.fromJson(Map<String, dynamic> json) {
    return WpFeaturedmedia(
      embeddable: json['embeddable'],
      href: json['href'],
    );
  }
}

class WpAttachment {
  String href;

  WpAttachment({required this.href});

  factory WpAttachment.fromJson(Map<String, dynamic> json) {
    return WpAttachment(
      href: json['href'],
    );
  }
}

class WpTerm {
  String taxonomy;
  bool embeddable;
  String href;

  WpTerm(
      {required this.taxonomy, required this.embeddable, required this.href});

  factory WpTerm.fromJson(Map<String, dynamic> json) {
    return WpTerm(
      taxonomy: json['taxonomy'],
      embeddable: json['embeddable'],
      href: json['href'],
    );
  }
}

class Curies {
  String name;
  String href;
  bool templated;

  Curies({required this.name, required this.href, required this.templated});

  factory Curies.fromJson(Map<String, dynamic> json) {
    return Curies(
      name: json['name'],
      href: json['href'],
      templated: json['templated'],
    );
  }
}

class Person {
  String name;
  String image;
  String caption;

  Person({required this.name, required this.image, required this.caption});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      image: json['image'],
      caption: json['caption'],
    );
  }
}

/* class Schema {
  List<WebPage> webPage;

  Schema({required this.webPage});

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      webPage:
          List<WebPage>.from(json['webPage'].map((x) => WebPage.fromJson(x))),
    );
  }
} */

class WebPage {
  String type;
  String id;
  String url;
  String name;
  IsPartOf isPartOf;
  String datePublished;
  String dateModified;
  Author author;
  Breadcrumb breadcrumb;
  String inLanguage;
  List<PotentialAction> potentialAction;

  WebPage({
    required this.type,
    required this.id,
    required this.url,
    required this.name,
    required this.isPartOf,
    required this.datePublished,
    required this.dateModified,
    required this.author,
    required this.breadcrumb,
    required this.inLanguage,
    required this.potentialAction,
  });

  factory WebPage.fromJson(Map<String, dynamic> json) {
    return WebPage(
      type: json['@type'],
      id: json['@id'],
      url: json['url'],
      name: json['name'],
      isPartOf: IsPartOf.fromJson(json['isPartOf']),
      datePublished: json['datePublished'],
      dateModified: json['dateModified'],
      author: Author.fromJson(json['author']),
      breadcrumb: Breadcrumb.fromJson(json['breadcrumb']),
      inLanguage: json['inLanguage'],
      potentialAction: List<PotentialAction>.from(
          json['potentialAction'].map((x) => PotentialAction.fromJson(x))),
    );
  }
}

/* class Excerpt {
  String rendered;
  bool protected;

  Excerpt({required this.rendered, required this.protected});

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(
      rendered: json['rendered'],
      protected: json['protected'],
    );
  }
} */

/* class Content {
  String rendered;
  bool protected;

  Content({required this.rendered, required this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json['rendered'],
      protected: json['protected'],
    );
  }
} */

/* class Title {
  String rendered;

  Title({required this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      rendered: json['rendered'],
    );
  }
} */

class Link {
  String rendered;

  Link({required this.rendered});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      rendered: json['rendered'],
    );
  }
}

/* class Guid {
  String rendered;

  Guid({required this.rendered});

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(
      rendered: json['rendered'],
    );
  }
}

class YoastHeadJson {
  String title;
  Robots robots;
  String canonical;
  OgLocale ogLocale;
  OgType ogType;
  OgTitle ogTitle;
  OgDescription ogDescription;
  OgUrl ogUrl;
  OgSiteName ogSiteName;
  ArticlePublishedTime articlePublishedTime;
  ArticleModifiedTime articleModifiedTime;
  List<OgImage> ogImage;
  Author author;
  TwitterCard twitterCard;
  TwitterMisc twitterMisc;
  Schema schema;

  YoastHeadJson({
    required this.title,
    required this.robots,
    required this.canonical,
    required this.ogLocale,
    required this.ogType,
    required this.ogTitle,
    required this.ogDescription,
    required this.ogUrl,
    required this.ogSiteName,
    required this.articlePublishedTime,
    required this.articleModifiedTime,
    required this.ogImage,
    required this.author,
    required this.twitterCard,
    required this.twitterMisc,
    required this.schema,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) {
    return YoastHeadJson(
      title: json['title'],
      robots: Robots.fromJson(json['robots']),
      canonical: json['canonical'],
      ogLocale: OgLocale.fromJson(json['og:locale']),
      ogType: OgType.fromJson(json['og:type']),
      ogTitle: OgTitle.fromJson(json['og:title']),
      ogDescription: OgDescription.fromJson(json['og:description']),
      ogUrl: OgUrl.fromJson(json['og:url']),
      ogSiteName: OgSiteName.fromJson(json['og:site_name']),
      articlePublishedTime:
          ArticlePublishedTime.fromJson(json['article:published_time']),
      articleModifiedTime:
          ArticleModifiedTime.fromJson(json['article:modified_time']),
      ogImage:
          List<OgImage>.from(json['og:image'].map((x) => OgImage.fromJson(x))),
      author: Author.fromJson(json['author']),
      twitterCard: TwitterCard.fromJson(json['twitter:card']),
      twitterMisc: TwitterMisc.fromJson(json['twitter:label1']),
      schema: Schema.fromJson(json['schema']),
    );
  }
}
 */
class OgDescription {
  String content;

  OgDescription({required this.content});

  factory OgDescription.fromJson(Map<String, dynamic> json) {
    return OgDescription(
      content: json['content'],
    );
  }
}

class OgImage {
  int width;
  int height;
  String url;
  String type;

  OgImage(
      {required this.width,
      required this.height,
      required this.url,
      required this.type});

  factory OgImage.fromJson(Map<String, dynamic> json) {
    return OgImage(
      width: json['width'],
      height: json['height'],
      url: json['url'],
      type: json['type'],
    );
  }
}

class OgLocale {
  String content;

  OgLocale({required this.content});

  factory OgLocale.fromJson(Map<String, dynamic> json) {
    return OgLocale(
      content: json['content'],
    );
  }
}

class OgSiteName {
  String content;

  OgSiteName({required this.content});

  factory OgSiteName.fromJson(Map<String, dynamic> json) {
    return OgSiteName(
      content: json['content'],
    );
  }
}

class OgTitle {
  String content;

  OgTitle({required this.content});

  factory OgTitle.fromJson(Map<String, dynamic> json) {
    return OgTitle(
      content: json['content'],
    );
  }
}

class OgType {
  String content;

  OgType({required this.content});

  factory OgType.fromJson(Map<String, dynamic> json) {
    return OgType(
      content: json['content'],
    );
  }
}

class OgUrl {
  String content;

  OgUrl({required this.content});

  factory OgUrl.fromJson(Map<String, dynamic> json) {
    return OgUrl(
      content: json['content'],
    );
  }
}

class Robots {
  String index;
  String follow;
  String maxSnippet;
  String maxImagePreview;
  String maxVideoPreview;
  String maxVideoPreviewLength;
  String canonical;
  String prev;
  String next;
  String twitterTitle;
  String twitterDescription;
  String twitterImage;
  String twitterImageAlt;
  String twitterPlayer;
  String twitterPlayerWidth;
  String twitterPlayerHeight;

  Robots({
    required this.index,
    required this.follow,
    required this.maxSnippet,
    required this.maxImagePreview,
    required this.maxVideoPreview,
    required this.maxVideoPreviewLength,
    required this.canonical,
    required this.prev,
    required this.next,
    required this.twitterTitle,
    required this.twitterDescription,
    required this.twitterImage,
    required this.twitterImageAlt,
    required this.twitterPlayer,
    required this.twitterPlayerWidth,
    required this.twitterPlayerHeight,
  });

  factory Robots.fromJson(Map<String, dynamic> json) {
    return Robots(
      index: json['index'],
      follow: json['follow'],
      maxSnippet: json['max-snippet'],
      maxImagePreview: json['max-image-preview'],
      maxVideoPreview: json['max-video-preview'],
      maxVideoPreviewLength: json['max-video-preview:length'],
      canonical: json['canonical'],
      prev: json['prev'],
      next: json['next'],
      twitterTitle: json['twitter:title'],
      twitterDescription: json['twitter:description'],
      twitterImage: json['twitter:image'],
      twitterImageAlt: json['twitter:image:alt'],
      twitterPlayer: json['twitter:player'],
      twitterPlayerWidth: json['twitter:player:width'],
      twitterPlayerHeight: json['twitter:player:height'],
    );
  }
}

class ArticlePublishedTime {
  String content;

  ArticlePublishedTime({required this.content});

  factory ArticlePublishedTime.fromJson(Map<String, dynamic> json) {
    return ArticlePublishedTime(
      content: json['content'],
    );
  }
}

class ArticleModifiedTime {
  String content;

  ArticleModifiedTime({required this.content});

  factory ArticleModifiedTime.fromJson(Map<String, dynamic> json) {
    return ArticleModifiedTime(
      content: json['content'],
    );
  }
}

/* class Author {
  String name;

  Author({required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
    );
  }
} */

class TwitterCard {
  String content;

  TwitterCard({required this.content});

  factory TwitterCard.fromJson(Map<String, dynamic> json) {
    return TwitterCard(
      content: json['content'],
    );
  }
}

class TwitterMisc {
  String label1;
  String content1;
  String label2;
  String content2;
  String label3;
  String content3;

  TwitterMisc({
    required this.label1,
    required this.content1,
    required this.label2,
    required this.content2,
    required this.label3,
    required this.content3,
  });

  factory TwitterMisc.fromJson(Map<String, dynamic> json) {
    return TwitterMisc(
      label1: json['label1'],
      content1: json['content1'],
      label2: json['label2'],
      content2: json['content2'],
      label3: json['label3'],
      content3: json['content3'],
    );
  }
}

/* class Schema {
  String context;
  List<WebPageElement> webPageElement;

  Schema({required this.context, required this.webPageElement});

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      context: json['@context'],
      webPageElement: List<WebPageElement>.from(
          json['@graph'].map((x) => WebPageElement.fromJson(x))),
    );
  }
} */

class WebPageElement {
  String type;
  String id;
  String url;
  String name;
  IsPartOf isPartOf;
  String datePublished;
  String dateModified;
  Author author;
  Breadcrumb breadcrumb;
  String inLanguage;
  List<PotentialAction> potentialAction;

  WebPageElement({
    required this.type,
    required this.id,
    required this.url,
    required this.name,
    required this.isPartOf,
    required this.datePublished,
    required this.dateModified,
    required this.author,
    required this.breadcrumb,
    required this.inLanguage,
    required this.potentialAction,
  });

  factory WebPageElement.fromJson(Map<String, dynamic> json) {
    return WebPageElement(
      type: json['@type'],
      id: json['@id'],
      url: json['url'],
      name: json['name'],
      isPartOf: IsPartOf.fromJson(json['isPartOf']),
      datePublished: json['datePublished'],
      dateModified: json['dateModified'],
      author: Author.fromJson(json['author']),
      breadcrumb: Breadcrumb.fromJson(json['breadcrumb']),
      inLanguage: json['inLanguage'],
      potentialAction: List<PotentialAction>.from(
          json['potentialAction'].map((x) => PotentialAction.fromJson(x))),
    );
  }
}

/* class PotentialAction {
  String type;
  List<String> target;

  PotentialAction({
    required this.type,
    required this.target,
  });

  factory PotentialAction.fromJson(Map<String, dynamic> json) {
    return PotentialAction(
      type: json['@type'],
      target: List<String>.from(json['target']),
    );
  }
}

class IsPartOf {
  String id;

  IsPartOf({required this.id});

  factory IsPartOf.fromJson(Map<String, dynamic> json) {
    return IsPartOf(
      id: json['@id'],
    );
  }
}

class Breadcrumb {
  String id;

  Breadcrumb({required this.id});

  factory Breadcrumb.fromJson(Map<String, dynamic> json) {
    return Breadcrumb(
      id: json['@id'],
    );
  }
}
 */