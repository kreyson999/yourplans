class TaskModel {
  int? id;
  String title;
  String description;
  String category;
  String taskColor;
  String iconData;
  TaskModel({this.id, required this.title, required this.description, required this.category, required this.taskColor, required this.iconData});

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    return TaskModel(id: json["id"], title: json["title"], description: json["description"], category: json["category"], taskColor: json["taskColor"], iconData: json["iconData"]);
  }

  Map<String, dynamic> toMap() => {
    "id" : id,
    "title" : title,
    "description" : description,
    "category" : category,
    "taskColor" : taskColor,
    "iconData" : iconData,
  };

}