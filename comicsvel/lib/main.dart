import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: fetchData(), // Appel à la fonction fetchData()
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Erreur lors du chargement des données');
          } else {
            return MyHomePage(
              title: 'Flutter Demo Home Page',
              data: snapshot.data, // Données de l'API
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.data});

  final String title;
  final dynamic data;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            const Text(
              'API Data:', // Titre pour les données de l'API
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.data.toString(), // Affiche les données de l'API
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<dynamic> fetchData() async {
  const publicKey = 'ecf339dd3245cb3e8f31267304392227';
  const privateKey = '855da28f6b127779e85aec25ccb59d1aa1bc8d9e';
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final hash = generateMd5(timestamp + privateKey + publicKey);

  final url =
      'https://gateway.marvel.com/v1/public/characters?apikey=$publicKey&ts=$timestamp&hash=$hash';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    throw Exception('Failed to fetch data');
  }
}

String generateMd5(String input) {
  var bytes = utf8.encode(
      input); // Convertit la chaîne de caractères en un tableau d'octets
  var digest = md5.convert(bytes); // Génère le hash MD5
  return digest
      .toString(); // Convertit le hash en une représentation de chaîne de caractères
}
