class LabelModel {
  final int id;
  final String labelName;

  LabelModel({required this.id, required this.labelName});

  factory LabelModel.fromJson(Map<String, dynamic> json) {
    return LabelModel(
      id: json['id'],
      labelName: json['label_name'],
    );
  }
}