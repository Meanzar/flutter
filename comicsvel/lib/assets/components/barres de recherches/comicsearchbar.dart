import 'package:flutter/material.dart';
import '../../templates/comicsdetails.dart';
import '../../app_colors.dart';
import '../../api/config.dart';
import '../cartes/comiccard.dart';

class SearchComicWidget extends StatefulWidget {
  final List<dynamic> comics;

  SearchComicWidget({required this.comics});

  @override
  _SearchComicWidgetState createState() => _SearchComicWidgetState();
}

class _SearchComicWidgetState extends State<SearchComicWidget> {
  List<dynamic> _searchResults = [];

  _searchComic(String searchString) {
    _searchResults.clear();
    if (searchString.isNotEmpty) {
      widget.comics.forEach((comic) {
        if (comic['name'].toLowerCase().contains(searchString.toLowerCase()) ||
            comic['description'].toLowerCase().contains(searchString.toLowerCase())) {
          _searchResults.add(comic);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              _searchComic(value);
            },
            decoration: InputDecoration(
              labelText: "Rechercher un comic",
              hintText: "Rechercher un comic",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
            ),
          ),
        ),
        _searchResults.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final comic = _searchResults[index];
                    return ComicCard(comic: comic);
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
