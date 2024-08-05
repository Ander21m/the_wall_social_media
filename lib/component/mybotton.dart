import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String name;
  const MyButton({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.black),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              name,
              style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
            )
          ]),
        ));
  }
}
