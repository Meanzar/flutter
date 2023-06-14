// character_card.dart

import 'package:flutter/material.dart';
import '../../../characterdetails.dart';

class CharacterCard extends StatelessWidget {
  final dynamic character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterName = character['name'];
    final characterDesc = character['description'];
    final comics = character['comics']['items'] as List<dynamic>;
    final characterThumbnail = character['thumbnail']['path'] + '.' + character['thumbnail']['extension'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CharacterDetailPage(character: character)),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                characterThumbnail,
                height: 100,
                width: 100,
              ),
              Text(
                characterName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
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
                    .map<Widget>((comic) => Text(comic['name'] ?? 'Unknown Comic'))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
