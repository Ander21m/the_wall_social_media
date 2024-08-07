

import 'package:flutter/material.dart';
import 'package:the_wall_social_media/pages/login.dart';
import 'package:the_wall_social_media/pages/signup.dart';

class LoginOrPassword extends StatefulWidget {
  const LoginOrPassword({super.key});

  @override
  State<LoginOrPassword> createState() => _LoginOrPasswordState();
}

class _LoginOrPasswordState extends State<LoginOrPassword> {

  bool isLogin = true;

  void toggle(){
    setState(() {
      isLogin = !isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginPage(onTap:toggle );
    }
    else{
      return RegisterPage(onTap:toggle );
    }
  }
}