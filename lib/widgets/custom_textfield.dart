import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Function(String) onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onSubmitted,
      controller: widget.controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.black),

        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.black),

        errorStyle: TextStyle(color: Colors.black),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
