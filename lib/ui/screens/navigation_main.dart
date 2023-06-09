import 'package:agentsvalorant/ui/views/favorites_view.dart';
import 'package:agentsvalorant/ui/views/home_view.dart';
import 'package:agentsvalorant/ui/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeView(),
      const SearchView(),
      const FavoritesView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF1E1F21),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
              gap: 8,
              padding: const EdgeInsets.all(16),
              backgroundColor: const Color(0xFF1E1F21),
              color: const Color(0xFFFF4654),
              activeColor: Colors.white,
              tabBackgroundColor: Color.fromARGB(255, 120, 120, 120),
              onTabChange: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                ),
              ]),
        ),
      ),
    );
  }
}

/*
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    /*
    final screens = [
      const SearchView(),
      const HomeView(),
      const FavoritesView()
    ];
    */

    final List<Widget> screens = [
      const SearchView(),
      const HomeView(),
      const FavoritesView(),
      const AgentDetail()
    ];

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
*/
