import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(primarySwatch: Colors.blue),
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
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> todos = [
    {'title': 'Faire les devoirs', 'done': false},
    {'title': 'Étudier pour l\'exam', 'done': false},
  ];

  void _addTodo() {
    setState(() {
      todos.add({'title': 'Nouvelle tâche', 'done': false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO App'),
      ),
      body: [
        _buildTasksPage(),
        _buildAgendaPage(),
        _buildProfilePage(),
      ][_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _addTodo,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tâches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildTasksPage() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: todos[index]['done'],
            onChanged: (value) {
              setState(() {
                todos[index]['done'] = value ?? false;
              });
            },
          ),
          title: Text(todos[index]['title']),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                todos.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildAgendaPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_month, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            'Agenda',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            'Mon Profil',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          const Text('Étudiante'),
        ],
      ),
    );
  }
}