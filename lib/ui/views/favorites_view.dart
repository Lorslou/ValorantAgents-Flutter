import 'package:agentsvalorant/enums/menu_Action.dart';
import 'package:agentsvalorant/models/agent_model.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_bloc.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_event.dart';
import 'package:agentsvalorant/services/network/api_service.dart';
import 'package:agentsvalorant/utilities/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final ApiService _apiService = ApiService();

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
