import 'package:agentsvalorant/db/cloud/cloud_favorites.dart';
import 'package:agentsvalorant/services/network/api_service.dart';
import 'package:agentsvalorant/utilities/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

typedef AgentCallback = void Function(CloudFavorite favoriteAgent);

class FavoriteAgentsListView extends StatelessWidget {
  final Iterable<CloudFavorite> favorites;
  final AgentCallback onDeleteAgent;
  final AgentCallback onTap;

  const FavoriteAgentsListView(
      {Key? key,
      required this.favorites,
      required this.onDeleteAgent,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites.elementAt(index);

        return ListTile(
          onTap: () {
            onTap(favorite);
          },
          title: Text(
            favorite.toString(),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteAgent(favorite);
              }
            },
            icon: const Icon(Icons.favorite_border),
          ),
        );
      },
    );
  }
}

/*
typedef AgentCallback = void Function(CloudFavorite favoriteAgent);

class FavoriteAgentsListView extends StatelessWidget {
  final Iterable<CloudFavorite> favorites;
  final AgentCallback onDeleteAgent;
  final AgentCallback onTap;

  const FavoriteAgentsListView(
      {Key? key,
      required this.favorites,
      required this.onDeleteAgent,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites.elementAt(index);

        return ListTile(
          onTap: () {
            onTap(favorite);
          },
          title: Text(
            favorite.toString(),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeleteAgent(favorite);
              }
            },
            icon: const Icon(Icons.favorite_border),
          ),
        );
      },
    );
  }
}
*/
