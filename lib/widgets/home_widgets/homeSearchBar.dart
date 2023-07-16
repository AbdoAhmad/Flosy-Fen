import 'package:flutter/material.dart';

class HomeSearchBar extends SearchDelegate {
  List<String> listOfResults = ["1", "2", "3", "4"];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query.isEmpty ? close(context, null) : query = '';
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));
  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List listOfSuggestions = listOfResults.where((element) {
      final result = element.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: listOfSuggestions.length,
      itemBuilder: (context, index) => ListTile(
          title: Text(listOfSuggestions[index]),
          onTap: () {
            query = listOfSuggestions[index];
            showResults(context);
          }),
    );
  }
}
