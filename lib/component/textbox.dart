
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback onPressed;
  const MyTextBox({super.key, required this.text, required this.sectionName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left:15,bottom:15),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(sectionName,style: TextStyle(color: Colors.grey.shade600)),
      
        IconButton(onPressed: 
        onPressed, icon: Icon(Icons.settings,color: Colors.grey.shade500))
      ],),

      Text(text)
    ],),);
  }
}