import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/mybotton.dart';
import 'package:the_wall_social_media/component/mytextbox.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            
            children: [
              const SizedBox(
                height: 60,
              ),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Welcome back,you've been missed!",
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true),
              const SizedBox(
                height: 20,
              ),
              MyButton(onTap: () {}, name: "Sign in"),
              const SizedBox(
                height: 15,
              ),
              const Spacer(),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",style:TextStyle(color: Colors.grey.shade700),),
                  
                  const SizedBox(width: 10,),
                  
                  const Text(
                    "Register now",
                    style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
