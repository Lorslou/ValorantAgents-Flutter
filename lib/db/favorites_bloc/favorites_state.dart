import 'package:agentsvalorant/models/agent_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class FavoritesState extends Equatable {
  final bool isLoading;
  const FavoritesState({
    required this.isLoading,
  });

  @override
  List<Object?> get props => [isLoading];
}

// controls the favorite state ON/OFF
class FavoritesStateShow extends FavoritesState {
  final List<AgentModel> favoriteAgents;
  const FavoritesStateShow({
    required this.favoriteAgents,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [favoriteAgents, isLoading];
}

class FavoritesStateError extends FavoritesState {
  final Exception exception;
  const FavoritesStateError({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [exception, isLoading];
}

class FavoritesStateUninitialized extends FavoritesState {
  const FavoritesStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading];
}
