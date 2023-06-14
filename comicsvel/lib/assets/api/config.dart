import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> fetchData() async {
  const publicKey = 'ecf339dd3245cb3e8f31267304392227';
  const privateKey = '855da28f6b127779e85aec25ccb59d1aa1bc8d9e';
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final hash = generateMd5(timestamp + privateKey + publicKey);

  final charactersurl =
      'https://gateway.marvel.com/v1/public/characters?apikey=$publicKey&ts=$timestamp&hash=$hash';

  final charactersresponse = await http.get(Uri.parse(charactersurl));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final characters = jsonData['data']['results'] as List<dynamic>;
    return characters;
  } else {
    throw Exception('Failed to fetch characters data');
  }
}


String generateMd5(String input) {
  var bytes = utf8.encode(
      input); // Convertit la chaîne de caractères en un tableau d'octets
  var digest = md5.convert(bytes); // Génère le hash MD5
  return digest
      .toString(); // Convertit le hash en une représentation de chaîne de caractères
}
