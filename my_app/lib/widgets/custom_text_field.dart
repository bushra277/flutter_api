import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final Widget? prefixIcon;
  final double? borderRadius;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.labelText = '',
      this.prefixIcon,
      this.borderRadius = 15});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
