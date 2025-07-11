


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:the_wall_social_media/Auth/loginorpassword.dart';
import 'package:the_wall_social_media/pages/HomePage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() , builder: (context,snapshot){
      if(snapshot.hasData){
        return const HomePage();
      }
      else{
        return const LoginOrPassword();
      }
    });
  }
}