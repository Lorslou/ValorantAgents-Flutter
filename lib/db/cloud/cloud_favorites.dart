import 'package:agentsvalorant/db/cloud/cloud_favorites_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudFavorite {
  final String documentId;
  final String ownerUserId;
  final String agentUuid;
  final String displayName;
  final String displayIcon;

  const CloudFavorite({
    required this.documentId,
    required this.ownerUserId,
    required this.agentUuid,
    required this.displayName,
    required this.displayIcon,
  });

  CloudFavorite.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()?[ownerUserIdFieldName],
        agentUuid = snapshot.data()?[agentIdFieldName],
        displayIcon = snapshot.data()?[displayIconFieldName],
        displayName = snapshot.data()?[displayNameFieldName];
}
