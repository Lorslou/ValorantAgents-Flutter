import 'package:agentsvalorant/db/cloud/cloud_favorites.dart';
import 'package:agentsvalorant/db/cloud/cloud_favorites_constants.dart';
import 'package:agentsvalorant/db/cloud/cloud_favorites_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudStorage {
  final favoriteAgents =
      FirebaseFirestore.instance.collection('favorite_agents');

  Future<CloudFavorite> addFavoriteAgent(
      {required String ownerUserId,
      required String agentUuid,
      required String displayIcon,
      required String displayName,
      required bool isFavorite}) async {
    try {
      final agentAlreadyOnDB = await favoriteAgents
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .where(agentIdFieldName, isEqualTo: agentUuid)
          .limit(1)
          .get();

      if (agentAlreadyOnDB.docs.isNotEmpty) {
        throw CouldNotAddFavoriteException();
      }

      final document = await favoriteAgents.add({
        ownerUserIdFieldName: ownerUserId,
        agentIdFieldName: agentUuid,
        displayIconFieldName: displayIcon,
        displayNameFieldName: displayName,
      });

      final fetchedFavorites = await document.get();
      return CloudFavorite(
        documentId: fetchedFavorites.id,
        ownerUserId: ownerUserId,
        agentUuid: agentUuid,
        displayIcon: displayIcon,
        displayName: displayName,
      );
    } catch (e) {
      //await showErrorDialog(context, 'An agent cannot be added to favorites if it is already in the list');
      throw CouldNotAddFavoriteException();
    }
  }

  Future<void> removeFavoriteAgent({required documentId}) async {
    try {
      await favoriteAgents.doc(documentId).delete();
    } catch (e) {
      throw CouldNotRemoveFavoriteException();
    }
  }

  Stream<Iterable<CloudFavorite>> getFavoriteAgents(
      {required String ownerUserId}) {
    final favoritesStream = favoriteAgents
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => CloudFavorite.fromSnapshot(doc)));
    return favoritesStream;
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}
