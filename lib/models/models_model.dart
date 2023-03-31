class ModelsModel {
  final String id;
  final String root;
  final String created;
  ModelsModel({required this.id, required this.root, required this.created});
  factory ModelsModel.fromJson(Map json) {
    return ModelsModel(
        id: json['id'],
        root: json['root'],
        created: json['created'].toString());
  }
  static List<ModelsModel> modelsFromsnapshot(List modelsnapshot) {
    return modelsnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
