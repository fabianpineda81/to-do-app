import 'package:todo_app/domain/datasource/abstract_todos_datasource.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:todo_app/domain/repositories/abstract_todo_repository.dart';

class TodoFirebaseRepositoryImpl extends AbstractTodoRepository{
  final AbstractTodosDatasource  abstractTodosDatasource;

  TodoFirebaseRepositoryImpl({required this.abstractTodosDatasource});
  @override
  Future<void> addTodo(UserEntity user,TodoEntity todo) {
    return abstractTodosDatasource.addTodo(user, todo);
  }

  @override
  Future<void> deleteTodo(UserEntity user,TodoEntity todo) {
    return abstractTodosDatasource.deleteTodo(user, todo);
  }

  @override
  Future<List<TodoEntity>> getTodosByUser() {
    return abstractTodosDatasource.getTodosByUser();
  }

  @override
  Future<void> updateTodo(UserEntity user, TodoEntity todo) {
   return abstractTodosDatasource.updateTodo(user, todo);
  }

}