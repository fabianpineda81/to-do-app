import 'package:flutter/material.dart';


class OutlinedIconAndTextSmallButton extends StatelessWidget {

  final IconData iconData;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textAndIconColor;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final bool isEnabled;
  final double rightPadding;

  const OutlinedIconAndTextSmallButton({
    super.key, 
    required this.iconData, 
    required this.text, 
    this.backgroundColor, 
    required this.borderColor, 
    required this.textAndIconColor, 
    this.onPressed, 
    this.textStyle, 
    this.padding,
    this.isEnabled = true,
    this.rightPadding = 20
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: isEnabled
            ? backgroundColor ?? Colors.white
            : Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          side: BorderSide(
            width: 1, 
            color: isEnabled
              ? borderColor ?? backgroundColor ?? Colors.white
              : Colors.black26,
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
          style: textStyle ?? Theme.of(context).textTheme.labelSmall?.copyWith(
            color: textAndIconColor ?? Theme.of(context).colorScheme.secondary,
          )
        ),
      ),
    );
  }
}