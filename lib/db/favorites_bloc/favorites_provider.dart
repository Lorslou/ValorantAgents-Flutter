import 'package:agentsvalorant/models/agent_model.dart';

abstract class FavoritesProvider {
  Future<void> initialize();
  Future<void> addAgentToFavorites({
    required String agentUuid,
    required String ownerUserId,
  });

  Future<void> removeAgentFromFavorites(
    AgentModel agent,
  );

  Future<List<AgentModel>> getFavoriteAgents();
}
