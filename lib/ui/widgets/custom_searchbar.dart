import 'package:flutter/material.dart';
import 'package:agentsvalorant/ui/delegates/search_agent_delegate.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.gamepad, color: colors.primary),
              const SizedBox(width: 5),
              //Text('Search agent', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchAgentDelegate(),
                  );
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
