
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:the_wall_social_media/theme/themprovider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title:  Text(
          "S E T T I N G",
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Container(
        
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Theme.of(context).colorScheme.primary,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              "Dark Mode",
              style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.inversePrimary),
              
            ),

            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode, onChanged: (value){
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
            })
          ],
        ),
      ),
    );
  }
}
