import 'package:flutter/material.dart';
import 'package:yourplans/models/category.dart';
import 'package:yourplans/models/task.dart';
import 'package:yourplans/screens/task_screen.dart';

class NextTaskWidget extends StatefulWidget {

  final List<TaskModel> taskData;
  final List<CategoryModel> categories;

  const NextTaskWidget({Key? key, required this.taskData, required this.categories}) : super(key: key);

  @override
  _NextTaskWidgetState createState() => _NextTaskWidgetState();
}

class _NextTaskWidgetState extends State<NextTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.taskData.length,
      itemBuilder: (context, index) {
        return taskCard(context, widget.taskData[index], index);
      },
    );
  }
  Widget taskCard(BuildContext context, TaskModel taskModel, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskScreen(taskModel: taskModel, index: index, categories: widget.categories,)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(int.parse(taskModel.taskColor)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(IconData(int.parse(taskModel.iconData), fontFamily:'MaterialIcons',), size: 40, color: Colors.white,),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(taskModel.title, style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white), overflow: TextOverflow.ellipsis,),
            ),
          ],
        ),
      ),
    );
  }
}
