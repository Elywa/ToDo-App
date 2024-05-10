import 'package:flutter/material.dart';
import 'package:to_do/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged});
  final String hintText;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required ';
        } else {
          return null;
        }
      },
      maxLines: maxLines,
      cursorColor: MyTheme.primaryColor,
      decoration: InputDecoration(
        border: buildTextFieldBorder(MyTheme.primaryColor),
        hintText: hintText,
        enabledBorder: buildTextFieldBorder(MyTheme.primaryColor),
        focusedBorder: buildTextFieldBorder(MyTheme.greenColor),
      ),
    );
  }

  OutlineInputBorder buildTextFieldBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
