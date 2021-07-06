import 'package:flutter/material.dart';
import 'package:yourplans/models/category.dart';
import 'package:yourplans/models/task.dart';
import 'package:yourplans/screens/category_creator_screen.dart';
import 'package:yourplans/screens/category_tasks_screen.dart';
import 'package:yourplans/screens/task_screen.dart';
import 'package:yourplans/services/sqflite_service.dart';
import 'package:yourplans/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  final List<TaskModel> taskData;
  final List<CategoryModel> categories;

  const HomeScreen({Key? key, required this.taskData, required this.categories}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<TaskModel> taskData;
  late List<CategoryModel> categories;

  SqfLiteService db = SqfLiteService();

  @override
  void initState() {
    taskData = widget.taskData;
    categories = widget.categories;
    super.initState();
  }

  void addTaskOrCategory() {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text("Co chcesz dodac?",),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryCreatorScreen()));
                },
                leading: Icon(Icons.category),
                title: Text("Add Category"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskScreen(categories: categories,)));
                },
                leading: Icon(Icons.task),
                title: Text("Add Task"),
              ),
            ),
          ],
        ),
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
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Add category"),
              subtitle: Text("Click to add category"),
            ),
          ],
        ),
      ),
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
      body: RefreshIndicator(
        onRefresh: () async {
          taskData =  await db.getData();
          categories = await db.getCategory();
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 3 - 24,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () async {
                            List<TaskModel> sortedData = [];
                            taskData.forEach((element) {
                              if (element.category == categories[index].categoryName) {
                                sortedData.add(element);
                              }
                            });
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryTasksScreen(taskData: sortedData, categoryName: categories[index].categoryName)));
                          },
                          child: CategoryWidget(categoryName: categories[index].categoryName, categoryColor: Color(int.parse(categories[index].categoryColor)), iconData: IconData(
                            int.parse(categories[index].iconData),
                            fontFamily: 'MaterialIcons',
                          ),),
                        ),
                      );
                    },)
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Najbliższe zadania",
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
                child: NextTaskWidget(taskData: taskData, categories: categories,),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskOrCategory();
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add, color: Colors.white, size: 35,),
      ),
    );
  }
}
