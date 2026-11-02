import 'package:flutter/material.dart';
import 'dart:math';
import '../api/todo_api.dart';
import '../models/todo.dart'; 

class TodoTile extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool?> onChanged;

  const TodoTile({super.key, required this.todo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        trailing: Checkbox(value: todo.completed, onChanged: onChanged), // Updated to .completed
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => TodoState();
}

class TodoState extends State<TodoScreen> {
  final _items = <Todo>[];
  final _input = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos(); 
  }

  Future<void> _loadTodos() async {
    try {
      final fetched = await fetchTodos();
      setState(() {
        _items.addAll(fetched);
      });
    } catch (e) {
      print('Failed to fetch todos: $e');
    }
  }

  void _add() {
    if (_input.text.isEmpty) return;
    setState(() {
      _items.add(Todo(
        userId: 1,
        id: Random().nextInt(99999), 
        title: _input.text,
        completed: false,
      ));
    });
    _input.clear();
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  int countDone() {
    int done = 0;
    for (var i = 0; i < _items.length; i++) {
      done += _items[i].completed ? 1 : 0;
    }
    return done;
  }

  void _toggle(int i) {
    setState(() {
      _items[i] = Todo(
        userId: _items[i].userId,
        id: _items[i].id,
        title: _items[i].title,
        completed: !_items[i].completed,
      );
    });
  }

  String? _filter;
  List<Todo> get visibleItems {
    return _items.where((t) => t.title.contains(_filter ?? '')).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _input,
              decoration: const InputDecoration(labelText: 'New Todo'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final todo = _items[index];
                
                return Dismissible(
                  key: ValueKey(todo.id), 
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red),
                  onDismissed: (_) {
                    setState(() {
                      _items.removeWhere((t) => t.id == todo.id);
                    });
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${todo.title} deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              _items.insert(index, todo);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: TodoTile(
                    todo: todo,
                    onChanged: (value) => _toggle(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
    );
  }
}