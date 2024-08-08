
import 'package:flutter/material.dart';

class MyCommentBox extends StatelessWidget {
  final VoidCallback onTap;
  const MyCommentBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(
         Icons.comment,
         color: Colors.grey,
        ));
  }
}