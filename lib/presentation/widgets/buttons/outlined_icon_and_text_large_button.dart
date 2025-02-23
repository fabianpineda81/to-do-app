import 'package:flutter/material.dart';


class OutlinedIconAndTextLargeButton extends StatelessWidget {

  final IconData iconData;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textAndIconColor;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  const OutlinedIconAndTextLargeButton({
    super.key, 
    required this.iconData, 
    required this.text, 
    this.backgroundColor, 
    this.borderColor, 
    this.textAndIconColor, 
    this.onPressed, 
    this.textStyle, 
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        side: BorderSide(
          width: 1, 
          color: borderColor ?? Theme.of(context).colorScheme.secondary
        ),
        padding: padding
      ),
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: textAndIconColor,
      ),
      label: Text(
        text,
        style: textStyle ?? Theme.of(context).textTheme.labelMedium?.copyWith(
          color: textAndIconColor ?? Theme.of(context).colorScheme.secondary,
        )
      ),
    );
  }
}