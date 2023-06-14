import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

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
      home: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Erreur lors du chargement des données');
          } else {
            final characters = snapshot.data as List<dynamic>;

            return MyHomePage(
              title: 'Flutter Demo Home Page',
              characters: characters,
            );
          }
        },
      ),
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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

                return ListTile(
                  title: Text(
                    characterName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: characterDesc != null
                      ? Text(characterDesc)
                      : const Text('Description not available'),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> fetchData() async {
  const publicKey = 'ecf339dd3245cb3e8f31267304392227';
  const privateKey = '855da28f6b127779e85aec25ccb59d1aa1bc8d9e';
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final hash = generateMd5(timestamp + privateKey + publicKey);
  const int limit = 50;
  final url =
      'https://gateway.marvel.com/v1/public/characters?apikey=$publicKey&ts=$timestamp&hash=$hash&limit=$limit';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final characters = jsonData['data']['results'] as List<dynamic>;
    return characters;
  } else {
    throw Exception('Failed to fetch data');
  }
}

String generateMd5(String input) {
  var bytes = utf8.encode(input);
  var digest = md5.convert(bytes);
  return digest.toString();
}
