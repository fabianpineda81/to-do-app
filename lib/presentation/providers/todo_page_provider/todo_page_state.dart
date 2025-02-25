import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/entities/user_entity.dart';
import 'package:todo_app/domain/utils/todo_status_enum.dart';

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