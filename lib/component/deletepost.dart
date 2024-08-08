

import 'package:flutter/material.dart';

class DeletePost extends StatelessWidget {
  final VoidCallback onTap;
  const DeletePost({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child:const Icon(
         Icons.delete,
         color: Colors.grey,
        ));
  }
}