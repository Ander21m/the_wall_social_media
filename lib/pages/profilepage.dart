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
              style: const TextStyle(color:Colors.white,),
            ),
            content: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                finalValue = value;
              },
              decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Enter new $editField"),
            ),
            actions: [
              MaterialButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("Cancel",style:  TextStyle(color: Colors.white),),
              ),
              MaterialButton(
                onPressed:()=> Navigator.of(context).pop(),
                child: const Text("Save",style:  TextStyle(color: Colors.white,)),
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
                  title:  Text(
                    "Profile Page",
                    style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  ),
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                body: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                     Icon(
                      Icons.person,
                      size: 72,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
                              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
                              style: TextStyle(color:  Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Error ${snapshot.error}", style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
              );
            }
          }
        });
  }
}
