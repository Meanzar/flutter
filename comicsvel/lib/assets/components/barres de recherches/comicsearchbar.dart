import 'package:flutter/material.dart';
import '../cartes/comiccard.dart'; 

class ComicSearchBar extends StatefulWidget {
  final List<dynamic> comics;

  ComicSearchBar({required this.comics});

  @override
  _ComicSearchBarState createState() => _ComicSearchBarState();
}

class _ComicSearchBarState extends State<ComicSearchBar> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = List.from(widget.comics); 
    _searchController.addListener(() {
      filterSearchResults(_searchController.text);
    });
  }


  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      print("recherche :" + query);

      List<dynamic> tempSearchList = [];
      widget.comics.forEach((comic) {
       if((comic['title'] != null && comic['title'].toLowerCase().contains(query.toLowerCase())) ||
          (comic['description'] != null && comic['description'].toLowerCase().contains(query.toLowerCase()))) {
          tempSearchList.add(comic);
          print("création de la liste filtrée");
        }
      }
      );
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(tempSearchList);
      });
      return;
    } else {
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(widget.comics);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final comic = _searchResults[index];
              return ComicCard(comic: comic);
            },
          ),
        ),
      ],
    );
  }
}
