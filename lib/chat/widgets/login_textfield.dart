import 'package:convo/utils/brand_color.dart';
import 'package:flutter/material.dart';

import '../../utils/helper_function.dart';
import '../../utils/textfield_styles.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool asteriks;
  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator, this.asteriks = false,
  });


  @override
  Widget build(BuildContext context) {
    final dark = DHelperFunctions.isDarkMode(context);
    return TextFormField(
      obscureText: asteriks,
      validator: (value) {
      if (validator != null) return validator!(value);
      return null;
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: ThemeTextStyles.loginTextFieldStyle,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: dark ? BrandColor.secondary : Colors.black)
          )),
    );
  }
}