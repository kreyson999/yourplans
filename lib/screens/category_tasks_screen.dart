import 'package:flutter/material.dart';
import 'package:yourplans/models/task.dart';
import 'package:yourplans/services/sqflite_service.dart';
import 'package:yourplans/widgets/next_task_widget.dart';

class CategoryTasksScreen extends StatefulWidget {

  final List<TaskModel> taskData;
  final String categoryName;

  const CategoryTasksScreen({Key? key, required this.taskData, required this.categoryName}) : super(key: key);

  @override
  _CategoryTasksScreenState createState() => _CategoryTasksScreenState();
}

class _CategoryTasksScreenState extends State<CategoryTasksScreen> {

  late List<TaskModel> taskData;


  SqfLiteService db = SqfLiteService();

  @override
  void initState() {
    taskData = widget.taskData;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.categoryName}",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Najbliższe zadania w kategorii",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 4,
                    color: Colors.grey.shade500,
                  ),
                ],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: NextTaskWidget(taskData: taskData, categories: [],),
            ),
          ),
        ],
      ),
    );
  }
}