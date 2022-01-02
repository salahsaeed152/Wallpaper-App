import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        top: 10.h,
        bottom: 10.h,
      ),
      child: Container(
        width: double.infinity,
        height: 2.h,
        color: Colors.grey[300],
      ),
    );
  }
}