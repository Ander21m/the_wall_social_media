
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_wall_social_media/Auth/auth.dart';

import 'package:the_wall_social_media/fbinfo.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: FirebaseOptions(apiKey: Info.instance.apiHere(), appId: Info.instance.appIDHere(), messagingSenderId: Info.instance.projectNumberHere(), projectId: Info.instance.projectIdHere()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}