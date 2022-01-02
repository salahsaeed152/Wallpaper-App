import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/models/photo_model.dart';
import 'package:wallpaper_application/modules/wallpaper_details_view/wallpaper_details_screen.dart';
import 'package:wallpaper_application/shared/providers/home_provider.dart';
import 'package:wallpaper_application/shared/styles/font_styles.dart';
import 'package:wallpaper_application/shared/widgets/components.dart';
import 'package:wallpaper_application/shared/widgets/custom_text.dart';
import 'package:wallpaper_application/shared/widgets/default_cached_image.dart';

class FavouritesScreen extends StatelessWidget {
  final List<PhotoModel> myFavouritePhotos;

  const FavouritesScreen({
    Key? key,
    required this.myFavouritePhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => SafeArea(
        child: Scaffold(
          body: myFavouritePhotos.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300.h,
                        child: SvgPicture.asset(
                          'assets/images/empty_cart.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                        text: 'No photos add yet! add some to your favourites',
                        textStyle: primaryTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : CustomGrid(
                  myFavouritePhotos: myFavouritePhotos,
                  homeProvider: homeProvider,
                ),
        ),
      ),
    );
  }
}

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    Key? key,
    required this.myFavouritePhotos,
    required this.homeProvider,
  }) : super(key: key);

  final List<PhotoModel> myFavouritePhotos;
  final HomeProvider? homeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: GridView.builder(
        itemCount: myFavouritePhotos.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: GestureDetector(
            onTap: () {
              navigateTo(
                  context,
                  WallpaperDetailsScreen(
                      imageUrl: myFavouritePhotos[index].image));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: DefaultCachedNetworkImage(
                        imageUrl: '${myFavouritePhotos[index].image}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.h,
                      ),
                    ),
                    Container(
                      height: 35.h,
                      width: 35.w,
                      margin: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            homeProvider!.removeFromFavourites(
                                photosModel: myFavouritePhotos[index],
                                index: index).then((value) {
                              myFavouritePhotos.removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
