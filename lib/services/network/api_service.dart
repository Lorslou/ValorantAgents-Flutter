import 'dart:developer';
import 'package:agentsvalorant/models/agent_model.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_route.dart';

class ApiService {
  Future<AgentModel?> getAgents() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.allAgents);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        AgentModel model = agentModelFromJson(response.body);
        return model;
      } else {
        log('Error fetching agents: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching agents: $e');
    }
    return null;
  }
}
