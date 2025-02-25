import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/utils/todo_status_enum.dart';
import 'package:todo_app/presentation/providers/auth_provider/auth_provider.dart';
import 'package:todo_app/presentation/providers/todo_page_provider/todo_page_provider.dart';
import 'package:todo_app/presentation/widgets/buttons/outlined_icon_and_text_small_button.dart';
import 'package:todo_app/presentation/widgets/profile_name_and_close_drawer.dart';

class TodoDrawer extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> _key ;

  const TodoDrawer(this._key, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TodoDrawerState();
}

class TodoDrawerState extends ConsumerState<TodoDrawer> {

  void setSelectState(TodoStatusEnum state){
    ref.watch(todosProvider.notifier).filterByState(state);
    widget._key.currentState?.closeDrawer();
  }
  

  @override
  Widget build(BuildContext context) {
  
    final filterStatus= ref.watch(todosProvider).filterState;
    final currentUser = ref.watch(authProvider).user;

    return Drawer(
      width: 300,
      elevation: 5,
      shadowColor: const Color(0x53989A40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top+20),
          ProfileNameAndCloseDrawer(profileName: '${currentUser?.name} '),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Todos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NavigateDrawerButton(
                  text: 'Todos pendientes',
                  isSelected: TodoStatusEnum.pending==filterStatus ,
                  onPressed: () => setSelectState(TodoStatusEnum.pending)
                ),
                _NavigateDrawerButton(
                  text: 'Todos completadas',
                  isSelected:TodoStatusEnum.complete==filterStatus,
                  onPressed: () => setSelectState(TodoStatusEnum.complete),
                )
              ],
            ),
          ),
          const Divider(),

          const Spacer(),
         
    
        ],
      ),
    );
  }
}


class _NavigateDrawerButton extends StatelessWidget {

  final String text;
  final bool isSelected;
  final void Function()? onPressed;

  const _NavigateDrawerButton({
    required this.text, 
    required this.isSelected, 
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlinedIconAndTextSmallButton(
        text: text,
        iconData: Icons.arrow_forward_ios_rounded,
        padding: const EdgeInsets.all(10),
        onPressed: onPressed,
        textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: isSelected 
            ? Colors.white
            : Theme.of(context).colorScheme.secondary
        ),
        borderColor: isSelected 
          ? Theme.of(context).colorScheme.primary 
          : Colors.white,
        backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primary
          : Colors.white,
        textAndIconColor: isSelected
          ? Colors.white
          : Theme.of(context).colorScheme.secondary 
      ),
    );
  }
}