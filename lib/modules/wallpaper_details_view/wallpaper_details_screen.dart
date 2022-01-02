import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/models/photo_model.dart';
import 'package:wallpaper_application/shared/helper/enum.dart';
import 'package:wallpaper_application/shared/providers/home_provider.dart';
import 'package:wallpaper_application/shared/widgets/components.dart';
import 'package:wallpaper_application/shared/widgets/custom_button.dart';
import 'package:wallpaper_application/shared/widgets/default_cached_image.dart';

class WallpaperDetailsScreen extends StatelessWidget {
  final String? imageUrl;
  const WallpaperDetailsScreen({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            DefaultCachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              // height: 220.h,
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomButton(
                          width: 220.h,
                          onPressed: () {
                            PhotoModel model = PhotoModel(
                              image: imageUrl,
                              isFavourite: 'isFavourite',
                            );
                            homeProvider.addPhotoToFavourites(photoModel: model);
                          },
                          text: 'Add To Fav',
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: CustomButton(
                          width: 220.h,
                          onPressed: () {
                            homeProvider.downloadImage(imageUrl!).then((value) {
                              showToast(
                                  text: 'Saved successfully',
                                  stateColor: ShowToastColor.success);
                            });
                          },
                          text: 'Download',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
