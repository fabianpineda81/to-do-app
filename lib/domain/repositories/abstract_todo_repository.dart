import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/entities/user_entity.dart';

abstract class AbstractTodoRepository {
    Future<List<TodoEntity>> getTodosByUser();
  Future<void> addTodo(UserEntity user,TodoEntity todo);
  Future<void> deleteTodo(UserEntity user,TodoEntity todo);
  Future<void> updateTodo(UserEntity user,TodoEntity todo);
}