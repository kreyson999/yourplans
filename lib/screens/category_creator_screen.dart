import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:yourplans/models/category.dart';
import 'package:yourplans/services/sqflite_service.dart';

class CategoryCreatorScreen extends StatefulWidget {
  const CategoryCreatorScreen({Key? key}) : super(key: key);

  @override
  _CategoryCreatorScreenState createState() => _CategoryCreatorScreenState();
}

class _CategoryCreatorScreenState extends State<CategoryCreatorScreen> {
  final _formKey = GlobalKey<FormState>();

  String? categoryName;
  String? categoryColor = "0xff607d8b";
  String? iconData = "58179";

  late SqfLiteService db;

  @override
  void initState() {
    db = SqfLiteService();
    super.initState();
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context, iconPackMode: IconPack.material);


    setState((){
      iconData = icon!.codePoint.toString();
    });

    debugPrint('Picked Icon:  ${icon!.codePoint}');
  }

  void selectColor() {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text("Wybierz kolor:"),
      content: BlockPicker(
        pickerColor: Colors.red,
        onColorChanged: (color) {
          this.setState(() {
            categoryColor = color.value.toString();
          });
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Zamknij"))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    categoryName = val;
                  });
                },
                initialValue: categoryName,
                validator: (val) => val!.length >= 2
                    ? null
                    : "You have to enter title 2+ chars",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Category Name",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Theme.of(context).primaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  _pickIcon();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(IconData(int.parse(iconData!), fontFamily:'MaterialIcons',), size: 40, color: Colors.white,),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text("Category Icon", style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  selectColor();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(int.parse(categoryColor!)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.color_lens, size: 40, color: Colors.white,),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text("Category Color", style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis,),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    db.insertCategory(CategoryModel(categoryName: categoryName!, categoryColor: categoryColor!, iconData: iconData!));
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Dodaj kategorie",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
