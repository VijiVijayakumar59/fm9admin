import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController textController;
  final String? Function(String?)? validator;

  const TextFormWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.textController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: TextFormField(
        validator: validator,
        controller: textController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: Icon(
            prefixIcon,
          ),
          suffixIcon: Icon(
            suffixIcon,
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(
              22,
            ),
          ),
        ),
      ),
    );
  }
}
