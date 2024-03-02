import 'package:flutter/material.dart';
import 'package:tasky/widgets/base_button.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const PrimaryButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      borderColor: Theme.of(context).colorScheme.primary,
      child: child,
    );
  }
}
