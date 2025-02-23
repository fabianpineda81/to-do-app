import 'package:flutter/material.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/presentation/widgets/todo/todo_card_body.dart';




class TodoCard extends ConsumerWidget {
  
  final TodoEntity todo;
  final int? todoNumber;

   const TodoCard({
    super.key,
    required this.todo,
    this.todoNumber
  });
  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8,left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderCardBody(todo: todo, todoNumber: todoNumber)
              ],
            ),
          ),
           
        ],
      ),
    );
    
  }
}