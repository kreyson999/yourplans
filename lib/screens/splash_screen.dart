import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yourplans/models/category.dart';
import 'package:yourplans/models/task.dart';
import 'package:yourplans/screens/home_screen.dart';
import 'package:yourplans/services/sqflite_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  List<TaskModel> taskData = [];
  List<CategoryModel> categories = [];
  late SqfLiteService db;

  @override
  void initState() {
    db = SqfLiteService();
    getData();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(taskData: taskData, categories: categories,)));
    });
    super.initState();
  }

  void getData() async {
    taskData = await db.getData();
    categories = await db.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png"),
          Text("Todo App", style: Theme.of(context).textTheme.headline2,),
        ],
      ),
    );
  }
}
