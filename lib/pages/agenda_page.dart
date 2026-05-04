import 'package:flutter/material.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month, size: 80, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 20),
          Text('Agenda', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('${now.day}/${now.month}/${now.year}'),
        ],
      ),
    );
  }
}
