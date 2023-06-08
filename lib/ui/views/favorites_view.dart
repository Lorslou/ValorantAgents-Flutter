import 'package:agentsvalorant/constants/navigation_routes.dart';
import 'package:agentsvalorant/db/cloud/cloud_favorites.dart';
import 'package:agentsvalorant/db/cloud/firebase_cloud_storage.dart';
import 'package:agentsvalorant/enums/menu_Action.dart';
import 'package:agentsvalorant/services/auth/auth_service.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_bloc.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_event.dart';
import 'package:agentsvalorant/ui/views/favorites_agents_list_view.dart';
import 'package:agentsvalorant/utilities/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late final FirebaseCloudStorage _favoriteAgentsService;
  String get ownerUserId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _favoriteAgentsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream:
            _favoriteAgentsService.getFavoriteAgents(ownerUserId: ownerUserId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allAgents = snapshot.data as Iterable<CloudFavorite>;
                return FavoriteAgentsListView(
                  favorites: allAgents,
                  onDeleteAgent: (agent) async {
                    await _favoriteAgentsService.removeFavoriteAgent(
                        documentId: agent.documentId);
                  },
                  onTap: (agent) {
                    Navigator.pushNamed(context, detailRoute, arguments: agent);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


/*
class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final ApiService _apiService = ApiService();
  late FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    super.initState();
    _favoritesBloc = FavoritesBloc(FirebaseCloudStorage());
    _favoritesBloc.add(InitializeFavorites());
  }

  @override
  void dispose() {
    _favoritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          bloc: _favoritesBloc,
          builder: (context, state) {
            if (state is FavoritesStateShow) {
              var favoriteAgents = state.favoriteAgents;
              return ListView.builder(
                itemCount: favoriteAgents.length,
                itemBuilder: (context, index) {
                  var agent = favoriteAgents[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 77, 77),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: agent.displayIcon.isNotEmpty
                              ? Image.network(agent.displayIcon)
                              : Container(),
                        ),
                        title: Text(
                          agent.displayName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          agent.developerName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is FavoritesStateError) {
              return const Center(child: Text('Error fetching data'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

*/

/*
class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final ApiService _apiService = ApiService();
  //late FavoritesBloc _favoritesBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        //TODO SWAP TO IMPLEMENT ONLY FAVORITE AGENTS IN VIEW
        child: FutureBuilder<AgentModel?>(
          future: _apiService.getAgents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var agents = snapshot.data!.data;
              return ListView.builder(
                itemCount: agents.length,
                itemBuilder: (context, index) {
                  var agent = agents[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 77, 77),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: agent.displayIcon.isNotEmpty
                              ? Image.network(agent.displayIcon)
                              : Container(),
                        ),
                        title: Text(
                          agent.displayName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          agent.developerName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
*/
