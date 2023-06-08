import 'package:agentsvalorant/db/cloud/cloud_favorites.dart';
import 'package:agentsvalorant/ui/views/favorites_agents_list_view.dart';
import 'package:flutter/material.dart';

class SearchFavoriteDelegate extends SearchDelegate {
  final Iterable<CloudFavorite> favorites;
  final AgentCallback onTap;

  SearchFavoriteDelegate(this.favorites, this.onTap);

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
    final filteredFavorites = favorites.where((favorite) {
      final favoriteName = favorite.displayName.toLowerCase();
      final queryLower = query.toLowerCase();
      return favoriteName.contains(queryLower);
    }).toList();

    return FavoriteAgentsListView(
      favorites: filteredFavorites,
      onTap: onTap,
      onDeleteAgent: (favoriteAgent) {},
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedFavorites = favorites.where((favorite) {
      final favoriteName = favorite.displayName.toLowerCase();
      final queryLower = query.toLowerCase();
      return favoriteName.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestedFavorites.length,
      itemBuilder: (context, index) {
        final favorite = suggestedFavorites[index];
        return ListTile(
          title: Text(favorite.displayName),
          onTap: () {
            query = favorite.displayName;
            showResults(context);
          },
        );
      },
    );
  }
}
