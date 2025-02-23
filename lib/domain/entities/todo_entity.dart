import 'package:todo_app/domain/utils/todo_status_enum.dart';

class TodoEntity {
   String id ; 
  final String userEmail;
  final String title;
  final String description;
  final TodoStatusEnum state ;
  final DateTime crationDate ; 
  final DateTime? endDate ;

  TodoEntity( {
    required this.id, 
    required this.userEmail, 
    required this.title, 
    required this.state, 
    required this.crationDate, 
    required this.endDate,
    required this.description,
    });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'title': title,
      'description':description,
      'state': state.name, 
      'crationDate': crationDate.toIso8601String(), 
      'endDate':  endDate?.toIso8601String(),
    };
  }
  TodoEntity copyWith({
    String? id,
    String? userEmail,
    String? title,
    String? description,
    TodoStatusEnum? state,
    DateTime? crationDate,
    DateTime? endDate,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      title: title ?? this.title,
      state: state ?? this.state,
      crationDate: crationDate ?? this.crationDate,
      endDate: endDate ?? this.endDate,
      description:description?? this.description
    );
  }


}