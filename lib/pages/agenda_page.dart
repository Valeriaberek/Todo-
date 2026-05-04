import 'package:flutter/material.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late final DateTime _today;
  late DateTime _selectedDay;

  final Map<int, List<String>> _eventsByDay = const {
    4: ['08:30  Réunion', '12:00  Déjeuner', '18:30  Sport'],
    12: ['09:00  Appel client', '14:00  Travail perso'],
    19: ['10:00  RDV', '16:30  Courses'],
    27: ['19:00  Dîner'],
  };

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _selectedDay = _today;
  }

  List<DateTime> _buildMonthDays(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final daysBefore = firstDayOfMonth.weekday % 7;
    final firstGridDay = firstDayOfMonth.subtract(Duration(days: daysBefore));

    return List.generate(42, (index) => firstGridDay.add(Duration(days: index)));
  }

  String _monthLabel(DateTime date) {
    const months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  List<String> _eventsForSelectedDay() {
    return _eventsByDay[_selectedDay.day] ?? const ['Aucun événement prévu'];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = _buildMonthDays(_today);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Calendrier',
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          _monthLabel(_today),
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    Text(
                      _monthLabel(_today),
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(child: Center(child: Text('D'))),
                    Expanded(child: Center(child: Text('L'))),
                    Expanded(child: Center(child: Text('M'))),
                    Expanded(child: Center(child: Text('M'))),
                    Expanded(child: Center(child: Text('J'))),
                    Expanded(child: Center(child: Text('V'))),
                    Expanded(child: Center(child: Text('S'))),
                  ],
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: days.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final isCurrentMonth = day.month == _today.month;
                    final isSelected = day.day == _selectedDay.day && day.month == _selectedDay.month;
                    final isToday = day.day == _today.day && day.month == _today.month;

                    return InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => setState(() => _selectedDay = day),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isToday ? theme.colorScheme.primary : Colors.grey.shade300,
                            width: isToday ? 2 : 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : isCurrentMonth
                                    ? Colors.black87
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Événements du ${_selectedDay.day}/${_selectedDay.month}',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ..._eventsForSelectedDay().map(
          (event) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: const Icon(Icons.event, size: 18),
                ),
                title: Text(event),
                subtitle: const Text('Appui long pour modifier plus tard'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
