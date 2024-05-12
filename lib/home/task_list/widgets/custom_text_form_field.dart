import 'package:flutter/material.dart';
import 'package:to_do/theme.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      this.maxLines = 1,
      this.onChanged,
      this.controller,
      this.keyboradTpe});
  final String hintText;
  final int maxLines;
  
  TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType? keyboradTpe;
  dynamic Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
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
