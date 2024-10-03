import 'package:evento_event_booking/resources/constants/user_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final String hintText;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final bool? obscureText;
  final Color? prefixIconColor;
  final Color? errorBorder;
  final Widget? suffixIcon;
  final Color? focusedBorderColor;
  final String ? prefixText;
  final ValueChanged<String> ? onChanged;
  CustomTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.validator,
    this.inputType,
    this.obscureText,
    this.prefixIconColor,
    this.prefixIcon,
    this.errorBorder,
    this.suffixIcon,
    this.focusedBorderColor,
    this.prefixText,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
      ),
      obscureText: obscureText ?? false,
      keyboardType: inputType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
        prefixText: prefixText ?? '',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
          width: 2,
          color: focusedBorderColor ?? AppColors.accentColor,
          style: BorderStyle.solid,
        )),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorBorder ?? Colors.red,
            style: BorderStyle.solid,
          ),
        ),
        suffixIcon: suffixIcon,
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: errorBorder ?? Colors.red,
          style: BorderStyle.solid,
        )),
        filled: true,
        fillColor: const Color(0xFFF6F5F0),
        prefixIcon: Icon(prefixIcon, color: prefixIconColor ?? Colors.grey),
        hintText: hintText,
        hintStyle: TextStyle(color: prefixIconColor ?? Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
    );
  }
}
