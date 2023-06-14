import 'package:flutter/material.dart';

class MarvelAppBar extends StatelessWidget {
  final String title;

  MarvelAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary, // .inversePrimary n'est pas une propriété standard, utilisons .secondary à la place
        title: Text(title),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),

      
    );
  }
}