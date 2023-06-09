import 'package:agentsvalorant/db/cloud/cloud_favorites.dart';
import 'package:agentsvalorant/db/cloud/firebase_cloud_storage.dart';
import 'package:agentsvalorant/models/agent_model.dart';
import 'package:agentsvalorant/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

typedef AgentCallback = void Function(CloudFavorite favoriteAgent);

class AgentDetail extends StatefulWidget {
  const AgentDetail({Key? key}) : super(key: key);

  @override
  State<AgentDetail> createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  late Datum agent;
  late final FirebaseCloudStorage _favoriteAgentsService;
  String get ownerUserId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _favoriteAgentsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    agent = ModalRoute.of(context)!.settings.arguments as Datum;

    return StreamBuilder(
      stream:
          _favoriteAgentsService.getFavoriteAgents(ownerUserId: ownerUserId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.active:
            if (snapshot.hasData) {
              final allAgents = snapshot.data as Iterable<CloudFavorite>;

              final isAgentFavorite = allAgents.any(
                  (favoriteAgent) => favoriteAgent.agentUuid == agent.uuid);

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(agent.background.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: const Text('Agent Detail'),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Image.network(
                              agent.fullPortrait.toString(),
                              width: double.infinity,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            color: const Color.fromARGB(220, 30, 31,
                                33), // Cambia el color de fondo aquí
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    agent.displayName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    agent.description,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Role:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 13),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                          agent.role!.displayIcon,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        agent.role!.displayName.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Abilities:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                          agent.abilities[0].displayIcon
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        agent.abilities[0].displayName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                          agent.abilities[1].displayIcon
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        agent.abilities[1].displayName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                          agent.abilities[2].displayIcon
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        agent.abilities[2].displayName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                          agent.abilities[3].displayIcon
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        agent.abilities[3].displayName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        if (isAgentFavorite) {
                          final favoriteAgent = allAgents.firstWhere(
                              (favoriteAgent) =>
                                  favoriteAgent.agentUuid == agent.uuid);
                          _favoriteAgentsService.removeFavoriteAgent(
                              documentId: favoriteAgent.documentId);
                        } else {
                          _favoriteAgentsService.addFavoriteAgent(
                            ownerUserId: ownerUserId,
                            agentUuid: agent.uuid,
                            displayIcon: agent.displayIcon,
                            displayName: agent.displayName,
                            isFavorite: true,
                          );
                        }
                      },
                      child: Icon(
                        isAgentFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endTop,
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
