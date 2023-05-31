import 'package:agentsvalorant/ui/screens/detail_agent.dart';
import 'package:agentsvalorant/ui/views/user/register_view.dart';
import 'package:flutter/material.dart';
import 'constants/navigation_routes.dart';
import 'ui/screens/navigation_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegisterView(),
        routes: {
          detailRoute: (context) => const AgentDetail(),
        });
  }
}
