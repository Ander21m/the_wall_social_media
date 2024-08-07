import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  const WallPost({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration:
                const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.person,
    
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20,)
          ,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(message)
            ],
          ),
        ],
      ),
    );
  }
}
