import 'package:flutter/material.dart';

class Todo {
  final String id = UniqueKey().toString();
  String title;
  bool done;
  Todo(this.title, {this.done = false});
}

class TodoTile extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool?> onChanged;

  const TodoTile({Key? key, required this.todo, required this.onChanged}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        trailing: Checkbox(value: todo.done, onChanged: onChanged),
      ),
    );
  }
}
class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => TodoState();
}

class TodoState extends State<TodoScreen> {
  final _items = <Todo>[];
  final _input = TextEditingController();

  void _add() {
    if (_input.text.isEmpty) return;
    setState(() {
      _items.add(Todo(_input.text));
    });
    _input.clear();
  }

  @override
  void dispose() {
    _input.dispose(); // Required cleanup
    super.dispose();
  }

  int countDone() {
    int done = 0;
    // Using < instead of <= prevents it from going out of bounds
    for (var i = 0; i < _items.length; i++) {
      done += _items[i].done ? 1 : 0;
    }
    return done;
  }

  void _toggle(int i) {
    // Wrapping in setState ensures the UI rebuilds
    setState(() {
      _items[i].done = !_items[i].done;
    });
  }

  String? _filter;
  List<Todo> get visibleItems {
    // Using ?? '' prevents a crash if _filter is null, avoiding the '!' force unwrap
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
                  key: ValueKey(todo.id), // Must use the unique ID, not the index
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
                    onChanged: (value) {
                      setState(() {
                        todo.done = value ?? false;
                      });
                    },
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