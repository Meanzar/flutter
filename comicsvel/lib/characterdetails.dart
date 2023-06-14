

import 'package:flutter/material.dart';

class CharacterDetailPage extends StatelessWidget {
  final dynamic character;

  const CharacterDetailPage({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterName = character['name'];
    final characterDesc = character['description'];
    final comics = character['comics']['items'] as List<dynamic>;
    final characterThumbnail = character['thumbnail']['path'] + '.' + character['thumbnail']['extension'];

    return Scaffold(
      appBar: AppBar(
        title: Text(characterName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              characterThumbnail,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              characterName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(characterDesc ?? 'Description not available'),
            const SizedBox(height: 16),
            const Text(
              'Comics:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: comics
                  .map<Widget>((comic) => Text(comic['name'] ?? 'Unknown Comic'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
