import 'package:agentsvalorant/constants/navigation_routes.dart';
import 'package:agentsvalorant/models/agent_model.dart';
import 'package:agentsvalorant/network/api_service.dart';
import 'package:flutter/material.dart';

class SearchAgentDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Brimstone',
    'Phoenix',
    'Sage',
    'Sova',
    'Viper',
    'Cypher',
    'Reyna',
    'Killjoy',
    'Breach',
    'Omen',
    'Jett',
    'Raze',
    'Skye',
    'Yoru',
    'Astra',
    'KAY/O',
    'Chamber',
    'Neon',
    'Fade',
    'Harbor',
    'Gekko',
  ];

  // section to clear the query
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  // to go back and close the searchbar
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<AgentModel?>(
      future: ApiService().getAgents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching agents'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No agents found'),
          );
        }

        AgentModel agentModel = snapshot.data!;

        final List<Datum> filteredAgents = agentModel.data.where((agent) {
          final agentName = agent.displayName.toLowerCase();
          final queryLower = query.toLowerCase();
          return agentName.contains(queryLower);
        }).toList();

        return ListView.builder(
          itemCount: filteredAgents.length,
          itemBuilder: (context, index) {
            Datum agent = filteredAgents[index];

            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, detailRoute, arguments: agent);
                },
                child: ListTile(
                  title: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 77, 77),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            agent.displayName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            agent.displayName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            agent.developerName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var agent in searchTerms) {
      if (agent.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(agent);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result), // result is the name of the index agent
          );
        });
  }
}
