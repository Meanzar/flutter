import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../api/config.dart';
/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  final pages = [
    FutureBuilder(
      future: fetchDataCharacters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Erreur lors du chargement des données');
        } else {
          final characters = snapshot.data as List<dynamic>;
          return MyHomePage(
            title: 'Comicsvel',
            characters: characters,
          );
        }
      },
    ),
    FutureBuilder(
  future: fetchDataComics(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return const Text('Erreur lors du chargement des données');
    } else {
      final comics = snapshot.data as List<dynamic>;
      return MyComicPage(
        title: 'Comicsvel',
        comics: comics,
      );
    }
  },
),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.face),
            label: 'Personnages',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories),
            label: 'Comics',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie),
            label: 'Films',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}

