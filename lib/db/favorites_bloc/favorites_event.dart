import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class FavoritesEvent {
  const FavoritesEvent();
}

// initialize favorites functionality
class InitializeFavorites extends FavoritesEvent {
  const InitializeFavorites();
}

class AddFavoriteAgent extends FavoritesEvent {
  final String agentUuid;
  const AddFavoriteAgent(this.agentUuid);
}

class RemoveFavoriteAgent extends FavoritesEvent {
  final String agentUuid;
  const RemoveFavoriteAgent(this.agentUuid);
}
