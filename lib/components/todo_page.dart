import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  final List<Map<String, dynamic>> todos;

  const TodoPage({super.key, required this.todos});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();

  void addTodo() {
    if (controller.text.isEmpty) return;

    setState(() {
      widget.todos.add({
        "title": controller.text,
        "favorite": false,
      });
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: "Nouvelle tâche",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: addTodo,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: widget.todos.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(widget.todos[i]["title"]),
                  trailing: IconButton(
                    icon: Icon(
                      widget.todos[i]["favorite"]
                          ? Icons.star
                          : Icons.star_border,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.todos[i]["favorite"] =
                            !widget.todos[i]["favorite"];
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}