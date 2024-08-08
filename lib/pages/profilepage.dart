import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/textbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void onSettingPressed(String editField) async{
    String finalValue = "";

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Text(
              "Edit $editField",
              style: const TextStyle(color: Colors.white),
            ),
            content: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                finalValue = value;
              },
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Enter new $editField"),
            ),
            actions: [
              MaterialButton(
                onPressed: Navigator.of(context).pop,
                child: Text("Cancel",style: const TextStyle(color: Colors.white),),
              ),
              MaterialButton(
                onPressed:()=> Navigator.of(context).pop(),
                child: Text("Save",style: const TextStyle(color: Colors.white),),
              ),
            ],
          );
        }
        
        );

        if(finalValue.trim().isNotEmpty){
          
          await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.email).update({
            editField : finalValue
          });
        }
        
      
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "Profile Page",
                    style: TextStyle(color: Colors.white),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey.shade900,
                ),
                backgroundColor: Colors.grey.shade300,
                body: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(
                      Icons.person,
                      size: 72,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("My Details",
                              style: TextStyle(color: Colors.grey.shade600)),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextBox(
                              text: data["Username"],
                              sectionName: "Username",
                              onPressed: () {
                                onSettingPressed("Username");
                              }),
                          MyTextBox(
                              text: data["Bio"],
                              sectionName: "Bio",
                              onPressed: () {
                                onSettingPressed("Bio");
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("My Posts",
                              style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            }
          }
        });
  }
}
