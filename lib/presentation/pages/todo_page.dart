import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/utils/todo_status_enum.dart';
import 'package:todo_app/presentation/providers/auth_provider.dart';
import 'package:todo_app/presentation/providers/todo_page_provider.dart';
import 'package:todo_app/presentation/shared/helpers/dialogs_helper.dart';
import 'package:todo_app/presentation/widgets/full_screen_loader.dart';
import 'package:todo_app/presentation/widgets/todo/todo_drawer.dart';
import 'package:todo_app/presentation/widgets/buttons/white_button.dart';
import 'package:todo_app/presentation/widgets/todo/todo_list.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});
  static GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context,ref) {
    bool isUpdating = ref.watch(todosProvider).isUpdating;
    final provider =  ref.watch(todosProvider);
    TodoStatusEnum filterState=provider.filterState;
    return Scaffold(
      key: scaffoldkey,
      drawer: TodoDrawer(scaffoldkey),
      appBar:  AppBar(
      elevation: 4,
      shadowColor: Colors.black26,
      surfaceTintColor: Colors.white,
      leading: WhiteIconButton(
        iconData: Icons.menu_rounded,
        onPressed: () => scaffoldkey.currentState?.openDrawer()
        ),
      title: Text("Todos ${filterState.description}"),
      actions:  [
       if(filterState == TodoStatusEnum.pending)  WhiteIconButton(
          iconData:  Icons.add_box_rounded,
          onPressed:(){
            ref.read(todosProvider.notifier).reset();
            DialogsHelper.showCreateTodoModal(context, ref);
            }
          ),
        WhiteIconButton(
          iconData:  Icons.logout_rounded,
          onPressed:()=> DialogsHelper.showConfirmDialog(
              context: context,
              text: '¿Esta seguro que desea salir de TodoApp?',
              onCancel: () => context.pop(),
              onConfirm: () => ref.read(authProvider.notifier).logout()
            ),
          )
      ],
    ),
      body: Stack(
        children: [
          const TodoList(),
           if(isUpdating) const FullScreenLoader(),
        ],
      ),
    );
  }



}





