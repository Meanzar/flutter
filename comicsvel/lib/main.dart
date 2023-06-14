// main.dart

import 'package:flutter/material.dart';
import './assets/api/config.dart';
import 'assets/components/fixed/appbar.dart';
import 'assets/components/fixed/navbar.dart';
import './assets/components/main/charactercard.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationExample(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.characters,
  }) : super(key: key);

  final String title;
  final List<dynamic> characters;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MarvelAppBar(title: widget.title), 
        preferredSize: Size.fromHeight(kToolbarHeight)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.characters.length,
                itemBuilder: (context, index) {
                  final character = widget.characters[index];
                  return CharacterCard(character: character);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
