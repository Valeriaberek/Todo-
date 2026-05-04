import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'pages/tasks_page.dart';
import 'pages/agenda_page.dart';
import 'pages/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: appTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // 0: Tasks, 1: Agenda, 2: Profile
  int _navIndex = 1; // 0: Menu, 1: Tasks, 2: Agenda, 3: Profile
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> todos = [
    {'title': 'Faire les devoirs', 'done': false},
    {'title': 'Étudier pour l\'exam', 'done': false},
  ];

  void _addTodo() => setState(() => todos.add({'title': 'Nouvelle tâche', 'done': false}));
  void _toggleDone(int i) => setState(() => todos[i]['done'] = !(todos[i]['done'] as bool));
  void _delete(int i) => setState(() => todos.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text(''), elevation: 0, backgroundColor: Colors.white, automaticallyImplyLeading: false),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu, size: 40, color: Colors.grey[700]),
                  const SizedBox(height: 10),
                  Text('Menu', style: TextStyle(color: Colors.grey[700], fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                _showParametres();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                _showAbout();
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: [
        TasksPage(todos: todos, onToggle: _toggleDone, onDelete: _delete),
        const AgendaPage(),
        const ProfilePage(),
      ]),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton.extended(onPressed: _addTodo, label: const Text('Ajouter'), icon: const Icon(Icons.add)) : null,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xFFFF77B0),
          indicatorColor: Colors.white24,
          height: 64,
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
          labelTextStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        ),
        child: NavigationBar(
          selectedIndex: _navIndex,
          onDestinationSelected: (index) {
            if (index == 0) {
              _scaffoldKey.currentState?.openDrawer();
            } else {
              setState(() {
                _navIndex = index;
                _selectedIndex = index - 1;
              });
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
            NavigationDestination(icon: Icon(Icons.task), label: 'Tâches'),
            NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Agenda'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }

  void _showParametres() {
    showDialog(context: context, builder: (c) {
      return AlertDialog(title: const Text('Paramètres'), content: const Text('Paramètres simples'), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Fermer'))]);
    });
  }

  void _showAbout() {
    showDialog(context: context, builder: (c) {
      return AlertDialog(title: const Text('À propos'), content: const Text('TODO App v1.0\nFun et simple'), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Fermer'))]);
    });
  }
}