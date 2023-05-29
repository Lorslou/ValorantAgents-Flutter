import 'package:flutter/material.dart';

class AgentDetail extends StatefulWidget {
  const AgentDetail({super.key});

  @override
  State<AgentDetail> createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Image(
          image:
              AssetImage('lib/assets/home_image2.jpg'), //TODO swap img from api
        )
      ],
    );
  }
}
