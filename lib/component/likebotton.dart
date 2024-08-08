import 'package:flutter/material.dart';

class LikeBotton extends StatelessWidget {
  final bool isLiked;

  final VoidCallback onPressed;

  const LikeBotton({super.key, required this.isLiked, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.grey,
        ));
  }
}
