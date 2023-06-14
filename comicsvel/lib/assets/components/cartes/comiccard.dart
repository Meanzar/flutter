import 'package:flutter/material.dart';
import '../../api/config.dart'; // Vous devrez créer cette page de détails pour les comics
import '../../templates/comicsdetails.dart';

class ComicCard extends StatelessWidget {
  final dynamic comic;

  const ComicCard({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicTitle = comic['title'];
    final comicDesc = comic['description'];
    final comicThumbnail = comic['thumbnail']['path'] + '.' + comic['thumbnail']['extension'];
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => comicDetailPage(comic: comic)),
        );
      },
      child: Card(
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
                      comicThumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                comicTitle,
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
