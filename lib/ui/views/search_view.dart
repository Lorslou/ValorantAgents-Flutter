import 'package:flutter/material.dart';
import 'package:agentsvalorant/ui/delegates/search_agent_delegate.dart';
import 'package:agentsvalorant/ui/widgets/custom_searchbar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomSearchBar(),
      ),
    );
  }
}
