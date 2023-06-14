import 'package:flutter/material.dart';
import './assets/api/config.dart';
import './assets/components/appbar.dart';
import './assets/components/navbar.dart';

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
            const Text(
              'Character Name:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.characters.length,
                itemBuilder: (context, index) {
                  final character = widget.characters[index];
                  final characterName = character['name'];
                  final characterDesc = character['description'];
                  final comics = character['comics']['items'] as List<dynamic>;

                  return ListTile(
                    title: Text(
                      characterName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(characterDesc ?? 'Description not available'),
                        const SizedBox(height: 8),
                        const Text(
                          'Comics:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: comics
                              .map<Widget>((comic) =>
                                  Text(comic['name'] ?? 'Unknown Comic'))
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
