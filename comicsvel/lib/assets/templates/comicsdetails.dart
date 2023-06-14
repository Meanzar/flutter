// comic_detail_page.dart

import 'package:flutter/material.dart';

class comicDetailPage extends StatelessWidget {
  final dynamic comic;

  const comicDetailPage({Key? key, required this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicTitle = comic['title'];
    final comicDesc = comic['description'];
    final comicPageCount = comic['pageCount'];
    final comicSeries = comic['series'];
    final comics = comic['comics']['items'] as List<dynamic>;
    final comicThumbnail = comic['thumbnail']['path'] + '.' + comic['thumbnail']['extension'];

    return Scaffold(
      appBar: AppBar(
        title: Text(comicTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              comicThumbnail,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              comicTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(comicDesc ?? 'Description not available'),
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
                  .map<Widget>((comic) => Text(comic['title'] ?? 'Unknown Comic'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
