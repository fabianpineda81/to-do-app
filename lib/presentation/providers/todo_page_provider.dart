import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:todo_app/domain/utils/todo_status_enum.dart';
import 'package:todo_app/infrastructure/datasource/todo_firebase_datasource_impl.dart';
import 'package:todo_app/infrastructure/repositories/todo_firebase_repository_impl.dart';
import 'package:todo_app/presentation/providers/auth_provider.dart';
import 'package:todo_app/presentation/shared/helpers/dates_helper.dart';

final todosProvider=StateNotifierProvider.autoDispose<TodoNotifier,TodoState>((ref){
    UserEntity user =  ref.read(authProvider).user!;
    final TodoFirebaseDatasourceImpl todoFirebaseDatasourceImpl=TodoFirebaseDatasourceImpl(); 
    final TodoFirebaseRepositoryImpl todoFirebaseRepositoryImpl= TodoFirebaseRepositoryImpl(abstractTodosDatasource: todoFirebaseDatasourceImpl);
    return TodoNotifier(
      user: user,
      todoFirebaseRepositoryImpl: todoFirebaseRepositoryImpl
    );
});

class TodoNotifier extends StateNotifier<TodoState>{
  TodoFirebaseRepositoryImpl todoFirebaseRepositoryImpl; 
  UserEntity user; 
  TodoNotifier({
    required this.user,
    required this.todoFirebaseRepositoryImpl
  }):super(
    TodoState(
      userEntity: user
    )
  ){
    listenTodos();
  }
  
  addTodo()async{
    TodoEntity todoEntity= TodoEntity(
      id: "", 
      userEmail: user.email, 
      title: state.newTodoTitle,
      description: state.newTodoDescription,
      state:TodoStatusEnum.pending , 
      crationDate:DateTime.now() , 
      endDate: null
      );
    state= state.copyWith(
      isUpdating: true
    );
    await todoFirebaseRepositoryImpl.addTodo(user, todoEntity);
    state= state.copyWith(
      isUpdating: false
    );
    reset();
  }
  completeTodo(TodoEntity todo)async{
    state= state.copyWith(
      isUpdating: true
    );
    final todoUpdated=todo.copyWith(
      state: TodoStatusEnum.complete,
      endDate: DateTime.now()
    );
    await todoFirebaseRepositoryImpl.updateTodo(user, todoUpdated);
     state= state.copyWith(
      isUpdating: false
    );

  }
  deleteTodo(TodoEntity todo)async{
    state= state.copyWith(
      isUpdating: true
    );
    await todoFirebaseRepositoryImpl.deleteTodo(user, todo);
      state= state.copyWith(
      isUpdating: false
    );
  }

  updateTodo(TodoEntity todo)async{
    final todoUpdate= todo.copyWith(
      title: state.newTodoTitle,
      description: state.newTodoDescription
    );
    todoFirebaseRepositoryImpl.updateTodo(user, todoUpdate);
    reset();

  }

  void updateTitle(String title) {
    state = state.copyWith(newTodoTitle: title.trim());
  }

  void updateDescription(String description) {
    state = state.copyWith(newTodoDescription: description.trim());
  }

  void loadTodoInfo(TodoEntity todo) {
    state= state.copyWith(
      newTodoDescription: todo.description,
      newTodoTitle: todo.title,
      isEditing: true
    );
  }
  bool isValid(){
    return state.newTodoDescription.trim().isNotEmpty && state.newTodoTitle.trim().isNotEmpty;
  }

  void reset() {
    state =state.copyWith(newTodoDescription:"",newTodoTitle: "",isEditing: false) ;
  }

  void filterByState(TodoStatusEnum totoState) {
    state = state.copyWith(
      totoToShow: getBystate(totoState,state.todos),
      filterState: totoState
    );
  }
  List<TodoEntity> getBystate(TodoStatusEnum totoState,List<TodoEntity> todos){
    return todos.where((todo) => todo.state == totoState).toList();
  }

 void listenTodos() {

    final todosRef = FirebaseFirestore.instance
        .collection("Todos")
        .doc(user.email)
        .collection("userTodos")
        .orderBy("crationDate", descending: true);

    todosRef.snapshots().listen((snapshot) {
      final todos = snapshot.docs.map((doc) {
        final data = doc.data();
        return TodoEntity(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'],
          state: TodoStatusEnumExtension.getEnumByDescription(data["state"]),
          crationDate: DateHelper.stringToDate(data["crationDate"]),
          endDate:data["endDate"]!=null?DateHelper.stringToDate(data["endDate"]):null,
          userEmail: data["userEmail"] ?? '',
        );
      }).toList();

      state = state.copyWith(
        todos: todos,
        totoToShow: getBystate(state.filterState,todos)
        );
    });
  }


}

class TodoState {
  final List<TodoEntity> todos; 
  final List<TodoEntity> totoToShow;
  final TodoEntity? todoSelect;
  final UserEntity userEntity; 
  final bool isUpdating;
  final String newTodoTitle;
  final String newTodoDescription;
  final bool isEditing;
  final TodoStatusEnum filterState;

  TodoState({
     this.todos=const [], 
     this.totoToShow=const[], 
     this.todoSelect,
     this.isUpdating=false,
     required this.userEntity,
     this.newTodoDescription="",
     this.newTodoTitle="",
     this.isEditing=false,
     this.filterState=TodoStatusEnum.pending
    }); 
    TodoState copyWith({
    List<TodoEntity>? todos,
    List<TodoEntity>? totoToShow,
    TodoEntity? todoSelect,
    UserEntity? userEntity,
    bool? isUpdating,
    String? newTodoTitle,
    String? newTodoDescription,
    bool? isEditing,
    TodoStatusEnum? filterState,
    
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      totoToShow: totoToShow ?? this.totoToShow,
      todoSelect: todoSelect ?? this.todoSelect,
      userEntity: userEntity ?? this.userEntity,
      isUpdating: isUpdating ?? this.isUpdating,
      newTodoDescription: newTodoDescription??this.newTodoDescription,
      newTodoTitle: newTodoTitle??this.newTodoTitle,
      isEditing:isEditing ?? this.isEditing,
      filterState:filterState??this.filterState
    );
  }
}