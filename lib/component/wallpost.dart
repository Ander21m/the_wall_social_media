import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/comment.dart';
import 'package:the_wall_social_media/component/commentbox.dart';
import 'package:the_wall_social_media/component/deletepost.dart';
import 'package:the_wall_social_media/component/likebotton.dart';
import 'package:the_wall_social_media/helper/helper.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final List<String> likes;
  final String postId;
  final String time;

  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.likes,
      required this.postId,
      required this.time});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  late bool isLiked;
  int cm = 0;

  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLiked = widget.likes.contains(FirebaseAuth.instance.currentUser!.email);
  }

  void postComment(String postComment) async {
    await FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": postComment,
      "CommentBy": FirebaseAuth.instance.currentUser!.email,
      "CommentTime": Timestamp.now(),
    });
  }

  void onCommentBoxTap() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Comment"),
            content: TextField(
              controller: commentController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  hintText: "Write a Comment",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  commentController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (commentController.text.isNotEmpty) {
                    postComment(commentController.text);
                    commentController.clear();
                  }
                },
                child: const Text(
                  "Post",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }

  void delete() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Post"),
            content: Text("Are you sure you want to delete this post?"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  final ref = await FirebaseFirestore.instance
                      .collection("User Posts")
                      .doc(widget.postId)
                      .collection("Comments")
                      .get();

                  for (var r in ref.docs) {
                    await FirebaseFirestore.instance
                        .collection("User Posts")
                        .doc(widget.postId)
                        .collection("Comments")
                        .doc(r.id)
                        .delete();
                  }

                  FirebaseFirestore.instance
                        .collection("User Posts")
                        .doc(widget.postId).delete();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.black),
                ),
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
          "Likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email])
        });
      } else {
        FirebaseFirestore.instance
            .collection("User Posts")
            .doc(widget.postId)
            .update({
          "Likes": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.email])
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "${widget.user}  -  ${widget.time}",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              ),
              if (widget.user == FirebaseAuth.instance.currentUser!.email)
                DeletePost(onTap: delete)
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
                  Text(widget.likes.length.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ))
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
                  Text(
                    cm.toString(),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .orderBy("CommentTime")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return const Text("Error!!!");
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((doc) {
                        return Comment(
                            text: doc["CommentText"],
                            user: doc["CommentBy"],
                            time: formatDate(doc["CommentTime"]));
                      }).toList(),
                    );
                  }
                }
              })
        ],
      ),
    );
  }
}
