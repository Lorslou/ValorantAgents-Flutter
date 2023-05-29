import 'package:flutter/material.dart';

class SearchAgentDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Brimstone',
    'Phoenix',
    'Sage',
    'Viper',
    'Cypher',
    'Reyna',
    'Killjoy',
    'Breach',
    'Omen',
    'Jett',
  ];

  // section to clear the query
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  // to go back and close the searchbar
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var agent in searchTerms) {
      if (agent.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(agent);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result), // result is the name of the index agent
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var agent in searchTerms) {
      if (agent.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(agent);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result), // result is the name of the index agent
          );
        });
  }
}
