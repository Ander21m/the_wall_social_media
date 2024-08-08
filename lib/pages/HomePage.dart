import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/mydrawer.dart';
import 'package:the_wall_social_media/component/mytextbox.dart';
import 'package:the_wall_social_media/component/wallpost.dart';
import 'package:the_wall_social_media/pages/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  void postMessage() {
    if (controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        "Message": controller.text,
        "User": FirebaseAuth.instance.currentUser!.email,
        "TimeStamp": Timestamp.now(),
        "Likes": []
        
      });
      setState(() {
        controller.clear();
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "The Wall",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        
      ),
    
      drawer:  MyDrawer(
        onProfileTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return const ProfilePage();
          }));
          
        } ,
        onLogoutTap: FirebaseAuth.instance.signOut,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy("TimeStamp")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return const Text("Error!!!");
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return WallPost(
                            message: snapshot.data!.docs[index]["Message"],
                            user: snapshot.data!.docs[index]["User"],
                            postId: snapshot.data!.docs[index].id,
                            likes: List<String>.from(snapshot.data!.docs[index]["Likes"] ?? []),
                            );
                      });
                }
              }
            },
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      controller: controller,
                      hintText: "Write something on the world",
                      obscureText: false),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: Center(
                    child: IconButton(
                        onPressed: postMessage, icon: const Icon(Icons.send)),
                  ),
                )
              ],
            ),
          ),
          Text("Login as a ${FirebaseAuth.instance.currentUser!.email}",style: TextStyle(color: Colors.grey.shade500),),
          const SizedBox(height:30,)
        ],
      ),
    );
  }
}
