import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDescriptionField extends StatefulWidget {
  final String text;
  final String validatorText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomDescriptionField(
      {Key? key,
      required this.text,
      required this.validatorText,
      required this.controller,
      required this.keyboardType})
      : super(key: key);

  @override
  State<CustomDescriptionField> createState() => _CustomDescriptionFieldState();
}

class _CustomDescriptionFieldState extends State<CustomDescriptionField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 9,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 24.sp, left: 10.sp),
        border: InputBorder.none,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffF2F2F2),
            ),
            borderRadius: BorderRadius.circular(25.r)),
        errorStyle: const TextStyle(decoration: TextDecoration.none),
        hintText: widget.text,
        filled: true,
        fillColor: const Color(0xffF2F2F2),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffF2F2F2),
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffF2F2F2),
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffF2F2F2),
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
    );
  }
}
