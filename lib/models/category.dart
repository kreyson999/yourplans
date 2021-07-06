class CategoryModel {
  int? id;
  String categoryName;
  String categoryColor;
  String iconData;

  CategoryModel(
      {this.id, required this.categoryName, required this.categoryColor, required this.iconData});

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(id: json["id"],
        categoryName: json["categoryName"],
        categoryColor: json["categoryColor"],
        iconData: json["iconData"]);
  }

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "categoryName": categoryName,
        "categoryColor": categoryColor,
        "iconData": iconData,
      };
}