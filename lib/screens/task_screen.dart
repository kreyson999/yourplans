import 'package:flutter/material.dart';
import 'package:yourplans/models/category.dart';
import 'package:yourplans/models/task.dart';
import 'package:yourplans/services/sqflite_service.dart';
import 'package:yourplans/widgets/category_widget.dart';

class TaskScreen extends StatefulWidget {
  final TaskModel? taskModel;
  final List<CategoryModel> categories;
  final int index;

  const TaskScreen({Key? key, this.taskModel, this.index = 0, required this.categories})
      : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String? title;
  String? description;
  String categoryName = "Osobiste";
  String taskColor = Colors.lightBlueAccent.value.toString();
  String iconData = Icons.person.codePoint.toString();

  final _formKey = GlobalKey<FormState>();
  late SqfLiteService db;

  @override
  void initState() {
    if (widget.taskModel != null) {
      title = widget.taskModel!.title;
      description = widget.taskModel!.description;
      categoryName = widget.taskModel!.category;
      taskColor = widget.taskModel!.taskColor;
      iconData = widget.taskModel!.iconData;
    }
    db = SqfLiteService();
    super.initState();
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
        actions: [
          widget.taskModel != null
              ? IconButton(
                  onPressed: () {
                    db.delete(widget.taskModel!.id!);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.restore_from_trash,
                    size: 30,
                  ),
                )
              : SizedBox.shrink(),
        ],
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
                    title = val;
                    print(title);
                  });
                },
                initialValue: title,
                validator: (val) => val!.length >= 2
                    ? null
                    : "You have to enter title 2+ chars",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
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
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    description = val;
                    print(description);
                  });
                },
                initialValue: description,
                validator: (val) => val!.length >= 2
                    ? null
                    : "You have to enter description 2+ chars",
                maxLines: 15,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Description",
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
              widget.taskModel == null ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3 - 24,
                child: ListView.builder(
                  itemCount: widget.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            categoryName = widget.categories[index].categoryName;
                            taskColor = widget.categories[index].categoryColor;
                            iconData = widget.categories[index].iconData;
                          });
                        },
                        child: CategoryWidget(categoryName: widget.categories[index].categoryName, categoryColor: Color(int.parse(widget.categories[index].categoryColor)), iconData: IconData(
                          int.parse(widget.categories[index].iconData),
                          fontFamily: 'MaterialIcons',
                        ),),
                      ),
                    );
                  },)
              ) : SizedBox.shrink(),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.taskModel == null) {
                      await db.insertData(
                        TaskModel(
                          title: title!,
                          description: description!,
                          category: categoryName,
                          taskColor: taskColor,
                          iconData: iconData,
                        ),
                      );
                      final snackBar =
                          SnackBar(content: Text("Dodano pomyślnie zadanie"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    } else {
                      TaskModel taskModel = widget.taskModel!;
                      taskModel.title = title!;
                      taskModel.description = description!;
                      taskModel.category = categoryName;
                      taskModel.taskColor = taskColor;
                      taskModel.iconData = iconData;
                      await db.update(
                        taskModel,
                      );
                      final snackBar = SnackBar(
                          content: Text("Edytowano pomyślnie zadanie"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: widget.taskModel != null
                          ? Text(
                              "Edytuj zadanie",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            )
                          : Text(
                              "Dodaj zadanie",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
