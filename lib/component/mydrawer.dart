import 'package:flutter/material.dart';
import 'package:the_wall_social_media/component/mytlisttile.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onSettingTap;
  const MyDrawer(
      {super.key,
      required this.onProfileTap,
      required this.onLogoutTap,
      required this.onSettingTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.tertiary,
              size: 80,
            ),
          ),
          MyListTile(
              title: "H O M E",
              
              icon: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onTap: Navigator.of(context).pop),
          MyListTile(
              title: "P R O F I L E",
              icon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onTap: onProfileTap),
          MyListTile(
              title: "S E T T I N G",
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onTap: onSettingTap),
          const Spacer(),
          MyListTile(
              title: "L O G O U T",
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onTap: onLogoutTap),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
