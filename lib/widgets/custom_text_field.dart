import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.maxLines,
      this.minLines,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary, fontSize: 16.0),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary, width: 1.5),
      ),
    );

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      decoration: inputDecoration.copyWith(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
    );
  }
}
