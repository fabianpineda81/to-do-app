import 'package:flutter/material.dart';



class LabelAndValueText extends StatelessWidget {

  final String label;
  final String value;
  final bool hasBorder;
  final bool hasSpacer;

  final double? textBoxWidth;

  const LabelAndValueText({
    super.key, 
    required this.label, 
    required this.value, 
    this.hasBorder = false,
    this.hasSpacer = false,
    
    this.textBoxWidth
  });

  @override
  Widget build(BuildContext context) {

    final textWidget = 
    SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary
          )
        ),
      );
      

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary
          ),
        ),
        hasSpacer
          ? const Spacer()
          : const SizedBox(width: 2),
        if(hasBorder) Container(
          width: textBoxWidth,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black26)
          ),
          child: textWidget,
        )
        else SizedBox(
          width: textBoxWidth,
          child: textWidget
        ),
      ],
    );
  }
}
