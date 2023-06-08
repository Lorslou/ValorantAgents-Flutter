import 'package:agentsvalorant/constants/navigation_routes.dart';
import 'package:agentsvalorant/enums/menu_action.dart';
import 'package:agentsvalorant/models/agent_model.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_bloc.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_event.dart';
import 'package:agentsvalorant/services/network/api_service.dart';
import 'package:agentsvalorant/ui/widgets/agent_filter.dart';
import 'package:agentsvalorant/utilities/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Datum>> agentListFuture;
  late final ApiService _apiService;
  String selectedRole = "All";

  @override
  void initState() {
    _apiService = ApiService();
    super.initState();
    agentListFuture = getFilteredAgents(selectedRole);
  }

  Future<List<Datum>> getFilteredAgents(String selectedRole) async {
    AgentModel? agentModel = await _apiService.getAgents();
    if (agentModel != null) {
      List<Datum> filteredAgents = agentModel.data.where((agent) {
        // Filtrar por rol si se selecciona un rol específico
        if (selectedRole != "All") {
          return agent.role?.displayName.name.toLowerCase() ==
              selectedRole.toLowerCase();
        } else {
          return true; // Mostrar todos los agentes si no se selecciona un rol específico
        }
      }).toList();
      return filteredAgents;
    } else {
      throw Exception('No se encontraron agentes');
    }
  }

  void filterAgentsByRole(String role) async {
    setState(() {
      selectedRole = role;
    });

    try {
      List<Datum> filteredAgents = await getFilteredAgents(selectedRole);
      setState(() {
        agentListFuture = Future.value(filteredAgents);
      });
    } catch (e) {
      // Manejar el error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: Column(
        children: [
          AgentFilter(
            selectedRole: selectedRole,
            onRoleSelected: filterAgentsByRole,
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Datum>>(
              future: agentListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error al cargar los agentes'),
                  );
                } else if (snapshot.hasData) {
                  List<Datum> agents = snapshot.data!;
                  return ListView.builder(
                    itemCount: agents.length,
                    itemBuilder: (context, index) {
                      var agent = agents[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, detailRoute,
                                arguments: agent);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 255, 77, 77),
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
                          ));
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No se encontraron agentes'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
