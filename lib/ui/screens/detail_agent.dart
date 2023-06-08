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
  //final ApiService _apiService = ApiService();
  String get ownerUserId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _favoriteAgentsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agent = ModalRoute.of(context)!.settings.arguments as Datum;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                agent.background.toString(),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Positioned(
              top: 0,
              right: 0,
              child: Image.network(
                agent.fullPortrait.toString(),
                width: double.infinity,
                height: 355,
                fit: BoxFit.cover,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent.displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(agent.description),
                    const SizedBox(height: 16),
                    const Text(
                      'Role:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        Text(agent.role!.displayName.name),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Abilities:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[0].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[0].displayName),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[1].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[1].displayName),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[2].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[2].displayName),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[3].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[3].displayName),
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
          _favoriteAgentsService.addFavoriteAgent(
              ownerUserId: ownerUserId,
              agentUuid: agent.uuid,
              displayIcon: agent.displayIcon,
              displayName: agent.displayName,
              isFavorite: true);
        },
        child: const Icon(Icons.favorite_border_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

/*
typedef AgentCallback = void Function(CloudFavorite favoriteAgent);

class AgentDetail extends StatefulWidget {
  final String agentId;
  const AgentDetail({Key? key, required this.agentId}) : super(key: key);

  @override
  State<AgentDetail> createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  late Datum agent;
  late final FirebaseCloudStorage _favoriteAgentsService;
  late final ApiService _apiService;
  String get ownerUserId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _favoriteAgentsService = FirebaseCloudStorage();
    _apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agent = ModalRoute.of(context)!.settings.arguments as Datum;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                agent.background.toString(),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Positioned(
              top: 0,
              right: 0,
              child: Image.network(
                agent.fullPortrait.toString(),
                width: double.infinity,
                height: 355,
                fit: BoxFit.cover,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent.displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(agent.description),
                    const SizedBox(height: 16),
                    const Text(
                      'Role:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        Text(agent.role!.displayName.name),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Abilities:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[0].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[0].displayName),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[1].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[1].displayName),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[2].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[2].displayName),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            agent.abilities[3].displayIcon.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(agent.abilities[3].displayName),
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
          _favoriteAgentsService.addFavoriteAgent(
              ownerUserId: ownerUserId,
              agentUuid: agent.uuid,
              displayIcon: agent.displayIcon,
              displayName: agent.displayName,
              isFavorite: true);
        },
        child: const Icon(Icons.favorite_border_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
*/
