// main.dart

import 'package:flutter/material.dart';
import 'assets/api/config.dart';
import 'assets/components/fixed/appbar.dart';
import 'assets/components/fixed/navbar.dart';
import 'assets/components/barres de recherches/charactersearchbar.dart';
import 'assets/components/barres de recherches/comicsearchbar.dart';
import 'assets/components/cartes/charactercard.dart'; 
import 'assets/components/cartes/comiccard.dart'; 
import 'assets/app_colors.dart';

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
      title: 'Comicsvel',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.fondAppli,
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
      body: CharacterSearchBar(characters: widget.characters),
    );
  }
}

class MyComicPage extends StatefulWidget {
  const MyComicPage({
    Key? key,
    required this.title,
    required this.comics,
  }) : super(key: key);

  final String title;
  final List<dynamic> comics;

  @override
  State<MyComicPage> createState() => _MyComicPageState();
}

class _MyComicPageState extends State<MyComicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MarvelAppBar(title: widget.title), 
        preferredSize: Size.fromHeight(kToolbarHeight)
      ),
      body: ComicSearchBar(comics: widget.comics),
    );
  }
}