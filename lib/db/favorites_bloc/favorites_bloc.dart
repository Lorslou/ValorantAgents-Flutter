import 'package:agentsvalorant/db/cloud/firebase_cloud_storage.dart';
import 'package:agentsvalorant/db/favorites_bloc/favorites_event.dart';
import 'package:agentsvalorant/db/favorites_bloc/favorites_provider.dart';
import 'package:agentsvalorant/db/favorites_bloc/favorites_state.dart';
import 'package:agentsvalorant/models/agent_model.dart';
import 'package:bloc/bloc.dart';



/*
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(FavoritesProvider provider) : super(const FavoritesStateUninitialized(isLoading: true)) {
    on<InitializeFavorites>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));
      }
    });
  }
}
*/