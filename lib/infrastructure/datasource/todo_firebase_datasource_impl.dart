import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/domain/datasource/abstract_todos_datasource.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/entities/user_entity.dart';

class TodoFirebaseDatasourceImpl  extends AbstractTodosDatasource{
  @override
  Future<void> addTodo(UserEntity user,TodoEntity todo) async {
    final db = FirebaseFirestore.instance;

  
    final newTodoRef = db
      .collection("Todos")
      .doc(user.email)
      .collection("userTodos")
      .doc();
      todo.id = newTodoRef.id;
    await newTodoRef.set(todo.toMap());

}

@override
Future<void> deleteTodo(UserEntity user, TodoEntity todo) async {
  final db = FirebaseFirestore.instance;

  try {
    await db
        .collection("Todos") // Colección principal
        .doc(user.email) // Documento del usuario
        .collection("userTodos") // Subcolección de todos
        .doc(todo.id) // Documento del todo a eliminar
        .delete();
  } on FirebaseException catch (e) {
    throw Exception("No se pudo eliminar el todo: ${e.message}");
  } catch (e) {
    throw Exception("Ocurrió un error inesperado al eliminar el todo");
  }
}


  @override
  Future<List<TodoEntity>> getTodosByUser() {
    // TODO: implement getTodosByUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(UserEntity user, TodoEntity todo) async {
    final db = FirebaseFirestore.instance;
  try {
    await db
        .collection("Todos")
        .doc(user.email) 
        .collection("userTodos") 
        .doc(todo.id) 
        .update(todo.toMap()); 
    } on FirebaseException catch (e) {
      throw Exception("No se pudo actualizar el todo: ${e.message}");
    } catch (e) {
      throw Exception("Ocurrió un error inesperado");
    }
  }
}