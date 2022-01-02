import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/modules/favourites_view/favourites_screen.dart';
import 'package:wallpaper_application/modules/search_view/search_screen.dart';
import 'package:wallpaper_application/shared/providers/home_provider.dart';
import 'package:wallpaper_application/shared/widgets/components.dart';
import 'package:wallpaper_application/shared/widgets/custom_grid_item_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, const SearchScreen());
                },
                iconSize: 40,
                color: Colors.black,
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  homeProvider
                      .getDataFromDatabase(homeProvider.database!)
                      .then((value) {
                    debugPrint('${homeProvider.myFavouritePhotos.length}');

                    navigateTo(
                      context,
                      FavouritesScreen(
                        myFavouritePhotos: homeProvider.myFavouritePhotos,
                      ),
                    );
                  });
                },
                iconSize: 40,
                color: Colors.black,
                icon: const Icon(
                  Icons.favorite_border_outlined,
                ),
              ),
            ],
          ),
          body: homeProvider.myPhotos.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    child: Column(
                      children: [
                        GridView.builder(
                          itemCount: homeProvider.myPhotos.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) => CustomGridItemWidget(
                            photos: homeProvider.myPhotos[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
