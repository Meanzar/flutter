import 'package:flutter/material.dart';
import '../cartes/charactercard.dart'; 

class CharacterSearchBar extends StatefulWidget {
  final List<dynamic> characters;

  CharacterSearchBar({required this.characters});

  @override
  _CharacterSearchBarState createState() => _CharacterSearchBarState();
}

class _CharacterSearchBarState extends State<CharacterSearchBar> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = List.from(widget.characters); // Initialize search results with all characters
    _searchController.addListener(() {
      filterSearchResults(_searchController.text);
    });
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<dynamic> tempSearchList = [];
      widget.characters.forEach((character) {
        if(character['name'].toLowerCase().contains(query.toLowerCase()) ||
           character['description'].toLowerCase().contains(query.toLowerCase())) {
          tempSearchList.add(character);
        }
      });
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(tempSearchList);
      });
      return;
    } else {
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(widget.characters);
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
              final character = _searchResults[index];
              return CharacterCard(character: character);
            },
          ),
        ),
      ],
    );
  }
}
