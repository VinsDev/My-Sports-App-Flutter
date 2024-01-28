class LinkModel {
  final int id;
  final String url;
  final List<String> labels;

  LinkModel({required this.id, required this.url, required this.labels});

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      id: json['id'],
      url: json['url'],
      labels: List<String>.from(json['labels']),
    );
  }
}