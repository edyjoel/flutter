import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? errorMessage;
  Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;

  CustomTextFormField({
    super.key,
    this.label,
    this.hintText,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      // borderSide: BorderSide(color: colors.primary),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary),
        ),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        errorText: errorMessage,
        focusColor: colors.primary,
      ),
    );
  }
}
