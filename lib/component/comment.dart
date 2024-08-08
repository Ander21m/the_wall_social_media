

import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment({super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding:const  EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Theme.of(context).colorScheme.primary,),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(text,style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
        const SizedBox(height: 5,),
        Row(children: [
          Text(user,style: TextStyle(color: Theme.of(context).colorScheme.surface),),
           Text("  -  ",style: TextStyle(color: Theme.of(context).colorScheme.surface)),
          Text(time,style: TextStyle(color: Theme.of(context).colorScheme.surface))
        ],)
      ],),
    );
  }
}