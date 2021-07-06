import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData iconData;

  const CategoryWidget(
      {Key? key,
      required this.categoryName,
      this.categoryColor = Colors.lightBlueAccent,
      this.iconData = Icons.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width / 3 - 24,
      height: MediaQuery.of(context).size.width / 3 - 24,
      decoration: BoxDecoration(
          color: categoryColor,
          borderRadius: BorderRadius.circular(10),),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 40, color: Colors.white,),
          FittedBox(
            child: Text(
              categoryName,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    color: Colors.grey.shade800,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
