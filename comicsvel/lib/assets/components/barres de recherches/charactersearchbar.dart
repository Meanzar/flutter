import 'package:flutter/material.dart';
import '../../templates/characterdetails.dart';
import '../../app_colors.dart';
import '../../api/config.dart';
import '../cartes/charactercard.dart';

class CharactersSearchBar extends StatefulWidget {
  const CharactersSearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<CharactersSearchBar> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _characters = [];
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchDataCharacters().then((characters) {
      setState(() {
        _characters = characters;
      });
    });

    _searchController.addListener(() {
      filterSearchResults(_searchController.text);
    });
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<dynamic> tempSearchList = [];
      _characters.forEach((character) {
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
        _searchResults.addAll(_characters);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return CharacterCard(character: _searchResults[index]);
            },
          ),
        ),
      ],
    );
  }
}
