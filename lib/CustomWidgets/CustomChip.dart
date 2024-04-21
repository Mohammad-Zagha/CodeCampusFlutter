import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:flutter/material.dart';
class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  AnimatedContainer(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric( vertical: 15, horizontal: 18),
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Color(0xff7BDEC8))
            : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        border: Border.all(
          color: selected
              ? (color ??Color(0xff7BDEC8))
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),

      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 10,
              child: AnimatedCheckmark(
                active: selected,
                color: Colors.white,
                size: const Size.square(32),
                weight: 5,
                duration: const Duration(milliseconds: 400),
              ),
            ),
            Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'Roboto'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}