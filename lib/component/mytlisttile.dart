
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;
  const MyListTile({super.key,required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        onTap: onTap,
        title: Text(title,style:  TextStyle(color: Theme.of(context).colorScheme.tertiary,),),
        leading: icon,
        iconColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}