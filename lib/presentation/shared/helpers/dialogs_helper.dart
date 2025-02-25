import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/providers/todo_page_provider/todo_page_provider.dart';
import 'package:todo_app/presentation/widgets/buttons/outlined_icon_and_text_large_button.dart';
import 'package:todo_app/presentation/widgets/buttons/outlined_text_large_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../domain/entities/todo_entity.dart';

class DialogsHelper {

  static bool isShowingBottonSheetDialog = false ; 

  static void showConfirmDialog({
    required BuildContext context,
    required String text,
    void Function()? onCancel,
    void Function()? onConfirm
  }) {

    final colors = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8) ,
        child: AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: SizedBox(
            width: width*0.7,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.secondary
              ),
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedIconAndTextLargeButton(
                    iconData: Icons.close_rounded,
                    text: "Cancelar", 
                    backgroundColor:Colors.white,
                    borderColor:Colors.black26, 
                    textAndIconColor: colors.secondary,
                    onPressed: onCancel,
                  ),
                  SizedBox(width: width*0.05),
                  OutlinedIconAndTextLargeButton(
                    iconData: Icons.check_outlined ,
                    text: "Aceptar", 
                    backgroundColor:colors.secondary,
                    borderColor: colors.secondary, 
                    textAndIconColor: Colors.white,
                    onPressed: onConfirm,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

 static void showCreateTodoModal(BuildContext context, WidgetRef ref,{TodoEntity? todo}) {


  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nuevo Todo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
             TextFormField(
              initialValue: todo==null?"":todo.title ,
              decoration: InputDecoration(
                labelText: "Título",
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                ),
                ),
              onChanged: (value) => ref.read(todosProvider.notifier).updateTitle(value),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: todo==null?"":todo.description,
              decoration: InputDecoration(
                labelText: "Descripción",
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), 
                )
                ),
              maxLines: 3,
              onChanged: (value) => ref.read(todosProvider.notifier).updateDescription(value),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(todosProvider.notifier).reset();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                ),
                const SizedBox(width: 8),
                OutlinedTextLargeButton(
                  text: "Guardar",
                  onPressed: () {
                    if(!ref.read(todosProvider.notifier).isValid()){
                      showToast("El titulo y descripción son obligatorios");
                      return;
                    }
                    if(ref.read(todosProvider).isEditing){
                      ref.read(todosProvider.notifier).updateTodo(todo!);
                    }else{
                      ref.read(todosProvider.notifier).addTodo();
                    }
                    ref.read(todosProvider.notifier).reset();
                    Navigator.pop(context);
                  },
                  
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

static void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating, // Hace que flote
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bordes redondeados
    ),
  );
}
static void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM, // Se muestra encima del modal
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


   
  
}