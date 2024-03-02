import 'package:flutter/material.dart';

class BoxContainer extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final double? height;
  final double? width;
  const BoxContainer(
      {super.key,
      this.child,
      this.padding = 16,
      this.height,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: 1.5),
          borderRadius: BorderRadius.circular(16.0)),
      child: child,
    );
  }
}
