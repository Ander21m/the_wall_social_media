import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/commentbox.dart';
import 'package:the_wall_social_media/component/likebotton.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final List<String> likes;
  final String postId;
  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.likes,
      required this.postId});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  late bool isLiked;
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLiked = widget.likes.contains(FirebaseAuth.instance.currentUser!.email);
  }

  void postComment(String postComment) async{
    await FirebaseFirestore.instance.collection("User Posts").doc(widget.postId).collection("Comments").add({
      "CommentText" :postComment,
      "CommentBy": FirebaseAuth.instance.currentUser!.email,
      "CommentTime": Timestamp.now(),
    });
  }

  void onCommentBoxTap() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:const Text("Add Comment"),
            content: TextField(
              controller: commentController,
              style: const TextStyle(color: Colors.black),
              decoration:const InputDecoration(
                  hintText: "Write a Comment",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            actions: [
              MaterialButton(
                onPressed: Navigator.of(context).pop,
                child:const Text("Cancel",style:  TextStyle(color: Colors.blue),),
              ),
              MaterialButton(
                onPressed:(){
                   Navigator.of(context).pop();
                   if(commentController.text.isNotEmpty){
                    postComment(commentController.text);
                   }
                   
                },
                child: const Text("Post",style:  TextStyle(color: Colors.blue),),
              ),
            ],
          );
        });
  }

  void onPressed() {
    setState(() {
      isLiked = !isLiked;

      if (isLiked) {
        FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .update({
          "Likes": FieldValue.arrayUnion([widget.user])
        });
      } else {
        FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .update({
          "Likes": FieldValue.arrayRemove([widget.user])
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   decoration:
          //       const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          //   padding: const EdgeInsets.all(10),
          //   child: const Icon(
          //     Icons.person,

          //     color: Colors.white,
          //   ),
          // ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(widget.message)
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeBotton(isLiked: isLiked, onPressed: onPressed),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.likes.length.toString())
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  MyCommentBox(onTap: onCommentBoxTap),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("0")
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
