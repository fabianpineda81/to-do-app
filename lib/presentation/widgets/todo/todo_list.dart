import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/presentation/providers/todo_page_provider.dart';
import 'package:todo_app/presentation/widgets/todo/todo_card.dart';


class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final todos= ref.watch(todosProvider).totoToShow;
    return Scaffold(
      body: todos.isEmpty
          ? const Center(child: Text("No hay tareas"))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return  TodoCard(todo: todo,todoNumber: index+1,);
              },
            ),
    );
  }
}
