import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const publicKey = 'ecf339dd3245cb3e8f31267304392227';
const privateKey = '855da28f6b127779e85aec25ccb59d1aa1bc8d9e';

Future<dynamic> fetchDataCharacters() async {
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final hash = generateMd5(timestamp + privateKey + publicKey);
  const int limit = 50;

  final charactersurl =
      'https://gateway.marvel.com/v1/public/characters?apikey=$publicKey&ts=$timestamp&hash=$hash&limit=$limit';

  final charactersresponse = await http.get(Uri.parse(charactersurl));

  if (charactersresponse.statusCode == 200) {
    final jsonData = jsonDecode(charactersresponse.body);
    final characters = jsonData['data']['results'] as List<dynamic>;
    return characters;
  } else {
    throw Exception('Failed to fetch characters data');
  }
}

Future<dynamic> fetchDataComics() async {
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final hash = generateMd5(timestamp + privateKey + publicKey);
  const int limit = 50;

  final comicssurl =
      'https://gateway.marvel.com/v1/public/comics?apikey=$publicKey&ts=$timestamp&hash=$hash&limit=$limit';

  final comicsresponse = await http.get(Uri.parse(comicssurl));

  if (comicsresponse.statusCode == 200) {
    final jsonData = jsonDecode(comicsresponse.body);
    final comics = jsonData['data']['results'] as List<dynamic>;
    return comics;
  } else {
    throw Exception('Failed to fetch comics data');
  }
}

String generateMd5(String input) {
  var bytes = utf8.encode(
      input); // Convertit la chaîne de caractères en un tableau d'octets
  var digest = md5.convert(bytes); // Génère le hash MD5
  return digest
      .toString(); // Convertit le hash en une représentation de chaîne de caractères
}