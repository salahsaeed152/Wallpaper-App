import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? text;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool? enabled;
  final String? hintText;

  const SearchWidget({
    Key? key,
    required this.controller,
    this.text,
    required this.onChanged,
    required this.hintText,
    this.onTap,
    this.enabled = true,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(
      color: Colors.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    );
    final styleHint = TextStyle(
      color: Colors.black54,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    );
    final style = text!.isEmpty ? styleHint : styleActive;

    return SizedBox(
      height: 50.h,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: controller,
        enabled: enabled,
        onTap: onTap,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
          disabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black)),
          prefixIcon: Icon(Icons.search, color: style.color),
          suffixIcon: text!.isNotEmpty
              ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller!.clear();
              onChanged!('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : null,
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: style,
        ),
        style: style,
        onChanged: onChanged,
      ),
    );
  }
}
