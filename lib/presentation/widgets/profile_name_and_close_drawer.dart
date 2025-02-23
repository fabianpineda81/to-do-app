import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/widgets/buttons/white_button.dart';


class ProfileNameAndCloseDrawer extends StatelessWidget {

  final String profileName;

  const ProfileNameAndCloseDrawer({
    super.key, 
    required this.profileName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.only(left: 5, right: 7),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
            shape: BoxShape.circle
          ),
          child: SvgPicture.asset('assets/icons/person_avatar.svg'),
        ),
        Text(
          profileName,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold
          ),
        ),
        WhiteIconButton(
          iconData: Icons.arrow_back_ios_new_rounded,
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
