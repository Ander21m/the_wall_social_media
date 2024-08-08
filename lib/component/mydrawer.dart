import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/mytlisttile.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;
  const MyDrawer({super.key, required this.onProfileTap, required this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            padding: const EdgeInsets.symmetric(vertical: 10),
            
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 80,
            ),
          ),
          MyListTile(title: "H O M E", icon:const  Icon(Icons.home), onTap: Navigator.of(context).pop),

          MyListTile(title: "P R O F I L E", icon: const Icon(Icons.person), onTap: onProfileTap),

          const Spacer(),

          MyListTile(title: "L O G O U T", icon: const Icon(Icons.logout), onTap: onLogoutTap),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
