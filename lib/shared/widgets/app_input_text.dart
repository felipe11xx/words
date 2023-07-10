import 'package:flutter/material.dart';
import 'package:words/shared/theme/colors.dart';
import 'package:words/shared/theme/typography.dart';

class AppInputText extends StatelessWidget {

  String label;
  String hint;
  bool isPassword;
  TextEditingController? textEditingController;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  TextInputAction? action;
  TextCapitalization textCapitalization;
  FocusNode? focusNode;
  FocusNode? nextFocus;
  int? maxLength;
  int? maxLines;
  IconButton? suffixIcon;
  final Key? textFieldKey;
  final void Function(String)? onChanged;

  AppInputText(this.label,
      this.hint,
      {super.key, this.isPassword = false,
        this.textEditingController,
        this.validator,
        this.keyboardType,
        this.action,
        this.focusNode,
        this.nextFocus,
        this.onChanged,
        this.textFieldKey,
        this.textCapitalization = TextCapitalization.none,
        this.maxLength , this.maxLines,
        this.suffixIcon });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFieldKey,
      maxLength: maxLength,
      controller: textEditingController,
      style: AppTextStyles.labelSmall,
      obscureText: isPassword,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines = 1,
      textInputAction: action,
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      onChanged: onChanged ?? (_) {},
      onFieldSubmitted: (text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: label,
          labelStyle: AppTextStyles.labelSmall,
          hintText: hint,
          hintStyle: AppTextStyles.labelSmall.copyWith(color: AppColors.neutral[400]),
          hintMaxLines: 1,
          suffixIcon: suffixIcon
      ),
    );
  }
}