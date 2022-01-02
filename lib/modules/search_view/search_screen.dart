import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_application/shared/providers/home_provider.dart';
import 'package:wallpaper_application/shared/widgets/custom_grid_item_widget.dart';
import 'package:wallpaper_application/shared/widgets/search_widget.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {

            homeProvider.isSearched = false;

             return true;
          },
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  SearchWidget(
                    controller: searchController,
                    text: searchController.text,
                    hintText: 'search here',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      homeProvider.searchForPhoto(text: value);
                    },
                  ),
                  SizedBox(height: 20.h),
                  if (homeProvider.isSearched)
                    Expanded(
                      child: GridView.builder(
                        itemCount: homeProvider.searchModel!.photos!.length,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) => CustomGridItemWidget(
                          photos: homeProvider.searchModel!.photos![index],
                        ),
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
