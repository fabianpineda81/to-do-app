import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/utils/todo_status_enum.dart';
import 'package:todo_app/presentation/enums.dart';
import 'package:todo_app/presentation/providers/todo_page_provider/todo_page_provider.dart';
import 'package:todo_app/presentation/shared/helpers/dates_helper.dart';
import 'package:todo_app/presentation/shared/helpers/dialogs_helper.dart';
import 'package:todo_app/presentation/widgets/inputs/label_and_value_text.dart';




class OrderCardBody extends ConsumerWidget {

  final SampleItem? selectedMenu;
  final TodoEntity todo;
  
  final int? todoNumber;

   const OrderCardBody({
    super.key,
    this.selectedMenu,
    required this.todo,
    this.todoNumber
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary
                )
              ),
            ),
             
            const SizedBox(width: 8),
              LabelAndValueText(
                label: 'N°:',
                value: todoNumber.toString(),
              ),
            
            PopupMenuButton<SampleItem>(
                initialValue: selectedMenu,
                onSelected: (SampleItem item) {
                  if(SampleItem.completeTodo== item){
                    ref.read(todosProvider.notifier).completeTodo(todo);
                  }
                  if(SampleItem.deleteTodo== item){
                    ref.read(todosProvider.notifier).deleteTodo(todo);
                  }
                  if(SampleItem.updateTodo== item){
                     ref.read(todosProvider.notifier).loadTodoInfo(todo);
                    DialogsHelper.showCreateTodoModal(context, ref,todo: todo);                   
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                  if(todo.state!= TodoStatusEnum.complete) const PopupMenuItem<SampleItem>(
                    value: SampleItem.updateTodo,
                    child: Text('Actualizar'),
                  ),
                  if(todo.state!= TodoStatusEnum.complete) const PopupMenuItem<SampleItem>(
                    value: SampleItem.completeTodo,
                    child: Text('Completar'),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.deleteTodo,
                    child: Text('Eliminar'),
                  ),
                ],
           ),
               
          ],
        ),
         Text(
          'ID: ${todo.id}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.normal
            )
          ),
           Text(
          'Descripción:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold
            )
          ),
          Text(
            todo.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.normal
            )
          ),
          LabelAndValueText(
              label: 'Fecha de creación:',
              value: DateHelper.dateTimeToString(todo.crationDate),//todo:Fecha
            ),
            if(todo.endDate!=null) LabelAndValueText(
              label: 'Fecha de finalizacion:',
              value: DateHelper.dateTimeToString(todo.endDate!),//todo:Fecha
            ),
            const Divider(),
            const SizedBox(height: 4),
            Text(
              'To-do traducido con google',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal
                )
              ),
            const SizedBox(height: 4),  
            Text(
              todo.translatedTitle??"Traduciendo...",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary
                )
              ),
            Text(
              'Descriptión:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              todo.translatedDescription??"",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.normal
              )
          )     
      ],
    );
  }
}