import 'package:agentsvalorant/models/agent_model.dart';
import 'package:agentsvalorant/services/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:agentsvalorant/ui/delegates/search_agent_delegate.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Agent'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchAgentDelegate());
              },
              icon: const Icon(Icons.search_sharp),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
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
      ),
    );
  }
}
