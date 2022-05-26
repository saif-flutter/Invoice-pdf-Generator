import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTextFormField extends StatefulWidget {
  final String text;
  final String validatorText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextFormField({Key? key, required this.text,required this.controller,required this.validatorText,required this.keyboardType}) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: (value){
        if(value==null || value.isEmpty )
          {
            return widget.validatorText;
          }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color:  Color(0xffF2F2F2),
            ),
            borderRadius: BorderRadius.circular(25)
        ),
        errorStyle: const TextStyle(
            decoration: TextDecoration.none
        ),

        contentPadding: EdgeInsets.only(
            left: 20.w
        ),

        hintText: widget.text,
        filled: true,
        fillColor: const Color(0xffF2F2F2),

        errorBorder: OutlineInputBorder(
          borderSide:  const BorderSide(color: Color(0xffF2F2F2), ),
          borderRadius: BorderRadius. circular(25.r),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide:  const BorderSide(color: Color(0xffF2F2F2), ),
          borderRadius: BorderRadius. circular(25.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(color: Color(0xffF2F2F2), ),
          borderRadius: BorderRadius. circular(25.r),
        ),

      ),

    );
  }
}
