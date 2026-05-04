import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
// import '../components/favorite_page.dart';
// import '../components/stats_page.dart';

class NavRailPage extends StatefulWidget {
  const NavRailPage({super.key});

  @override
  State<NavRailPage> createState() => _NavRailPageState();
}

class _NavRailPageState extends State<NavRailPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> todos = [];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              if (index == 4) {
                theme.toggleDark();
                return;
              }

              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              const NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text("Todo"),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.star),
                label: Text("Favoris"),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text("Stats"),
              ),

              const NavigationRailDestination(
                icon: Icon(Icons.palette),
                label: Text("Color"),
              ),

              NavigationRailDestination(
                icon: Icon(
                  theme.isDark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                label: const Text("Theme"),
              ),
            ],
          ),

          const VerticalDivider(),

          // Expanded(
          //   child: _selectedIndex == 0
          //       ? TodoPage(todos: todos)
          //       : _selectedIndex == 1
          //           // ? FavoritePage(todos: todos)
          //           // : StatsPage(todos: todos),
          // ),
        ],
      ),
    );
  }
}