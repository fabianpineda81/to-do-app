import 'package:flutter/material.dart';

class WhiteIconButton extends StatelessWidget {

  final IconData iconData;
  final void Function()? onPressed;

  const WhiteIconButton({
    super.key, 
    required this.iconData, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Icon(
        iconData,
        color: Theme.of(context).colorScheme.secondary,
        size: 35,
      ),
    );
  }
}