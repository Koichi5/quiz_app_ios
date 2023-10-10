import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines,
    this.error,
    this.onChanged,
    this.suffixIcon,
    this.helperText,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? error;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final errorColor = Theme.of(context).colorScheme.error;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: screenWidth * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (helperText != null && helperText != "" && helperText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(helperText!, style: const TextStyle(fontSize: 13)),
            ),
          TextField(
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType ?? TextInputType.text,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              filled: true,
              hintText: title,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: error?.isNotEmpty ?? false ? errorColor : primaryColor,
                ),
              ),
            ),
          ),
          if (error?.isNotEmpty ?? false)
            Text(
              error!,
              style: TextStyle(fontSize: 12, color: errorColor),
            )
        ],
      ),
    );
  }
}
