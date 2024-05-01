import 'package:flutter/material.dart';
import 'package:to_do/theme.dart';


class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      this.maxLines = 1,
      this.onChanged,
      this.keyboradTpe});
  final String hintText;
  final int maxLines;
  
  TextInputType? keyboradTpe;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        onChanged: onChanged,
        validator: (data) {
          if (data == null || data.isEmpty) {
            return 'field is required';
          } else {
            return null;
          }
        },
        keyboardType: keyboradTpe,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: MyTheme.greyColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
