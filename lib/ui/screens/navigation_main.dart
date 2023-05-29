import 'package:agentsvalorant/ui/screens/detail_agent.dart';
import 'package:agentsvalorant/ui/views/favorites_view.dart';
import 'package:agentsvalorant/ui/views/home_view.dart';
import 'package:agentsvalorant/ui/views/search_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const SearchView(),
      const HomeView(),
      const FavoritesView()
    ];
    /*

    final List<Widget> screens [
      const SearchView(),
      const HomeView(),
      const FavoritesView(),
      const AgentDetail()
    ];
    */

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
