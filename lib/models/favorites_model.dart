import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteAgent {
  final String agentUuid;
  final String userUid;

  FavoriteAgent({
    required this.agentUuid,
    required this.userUid,
  });

// provides a way to create data model objects from the data stored in the database
  factory FavoriteAgent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteAgent(
      agentUuid: data['agentUuid'],
      userUid: data['userUid'],
    );
  }

// provides a way to serialize the data model object and convert it into a format that can
// be easily stored and retrieved from the db
  Map<String, dynamic> toFirestore() {
    return {
      'agentUuid': agentUuid,
      'userUid': userUid,
    };
  }
}
