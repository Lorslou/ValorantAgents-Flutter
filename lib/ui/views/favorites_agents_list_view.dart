import 'package:agentsvalorant/constants/navigation_routes.dart';
import 'package:agentsvalorant/db/cloud/cloud_favorites.dart';
import 'package:agentsvalorant/models/agent_model.dart';
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
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  onTap(favorite);
                },
                leading: Container(
                  width: 60,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 77, 77),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: favorite.displayIcon.isNotEmpty
                      ? Image.network(favorite.displayIcon)
                      : Container(),
                ),
                title: Text(
                  favorite.displayName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDeleteDialog(context);
                    if (shouldDelete) {
                      onDeleteAgent(favorite);
                    }
                  },
                  icon: const Icon(Icons.favorite),
                ),
              ),
            ),
          );
        });
  }
}
