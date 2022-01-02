import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_application/modules/wallpaper_details_view/wallpaper_details_screen.dart';
import 'components.dart';
import 'default_cached_image.dart';

class CustomGridItemWidget extends StatelessWidget {
  const CustomGridItemWidget({
    Key? key,
    required this.photos,
  }) : super(key: key);

  final dynamic photos;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: GestureDetector(
        onTap: () {
          navigateTo(context, WallpaperDetailsScreen(imageUrl: photos!.src!.large));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 220.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: DefaultCachedNetworkImage(
                  imageUrl: '${photos!.src!.large}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}