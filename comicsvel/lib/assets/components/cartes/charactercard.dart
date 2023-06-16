import 'package:flutter/material.dart';
import '../../templates/characterdetails.dart';
import '../../app_colors.dart';

class CharacterCard extends StatelessWidget {
  final dynamic character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterName = character['name'];
    final characterDesc = character['description'];
    final comics = character['comics']['items'] as List<dynamic>;
    final characterThumbnail = character['thumbnail']['path'] + '.' + character['thumbnail']['extension'];
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CharacterDetailPage(character: character)),
        );
      },
      child: Card(
        color: AppColors.fondClair,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: 100,
                ),
                width: screenWidth * 0.7, // Set the width to 70% of the screen width
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 1,
                    child: Image.network(
                      characterThumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                characterName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
