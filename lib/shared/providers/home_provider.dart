import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_application/models/home_data_model.dart';
import 'package:wallpaper_application/models/photo_model.dart';
import 'package:wallpaper_application/models/search_model.dart';
import 'package:wallpaper_application/shared/helper/enum.dart';
import 'package:wallpaper_application/shared/network/remote/dio_helper.dart';
import 'package:wallpaper_application/shared/network/remote/end_points.dart';
import 'package:wallpaper_application/shared/widgets/components.dart';

class HomeProvider extends ChangeNotifier {

  HomeDataModel? homeDataModel;
  List<HomeDataPhotos> myPhotos = [];

  SearchModel? searchModel;

  bool isSearched = false;

  Database? database;
  static const int _version = 1;
  static const String tableName = 'favourites';

  List<PhotoModel> myFavouritePhotos = [];
  List<Photos> searchedPhotos = [];

  File? downloadedImage;

  HomeProvider() {
    getPhotos();
  }


  /// [getPhotos] this function for getting random photos from Pexels API
  Future<void> getPhotos() async {
    await DioHelper.getData(
      path: EndPoints.getPhoto,
    ).then((value) {
      homeDataModel = HomeDataModel.fromJson(value.data);

      for (var element in homeDataModel!.photos!) {
        myPhotos.add(element);
      }
      debugPrint(
          'searchModel!.photos!.length = ${homeDataModel!.photos!.length}');
    });

    notifyListeners();
  }

  /// [searchForPhoto] this function for search about photo using Pexels API
  Future<void> searchForPhoto({String? text}) async {
    if (text!.isNotEmpty) {
      isSearched = true;
      await DioHelper.getData(
        path: EndPoints.search,
        query: {
          'query': text,
        },
      ).then((value) {
        searchModel = SearchModel.fromJson(value.data);

        debugPrint('${searchModel!.photos!.length}');
      });
    } else {
      isSearched = false;
    }
    debugPrint('$isSearched');
    notifyListeners();
  }

  /// [initDb] this function for create our local database
  Future<void> initDb() async {
    String _path = join(await getDatabasesPath(), 'favourites.db');

    await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
      // When creating the db, create the table
      debugPrint('start creating DB');

      database = await db.execute('''CREATE TABLE $tableName (
                id integer primary key autoincrement, 
                image text not null,
                isFavourite string not null)
                ''').then((value) {
        debugPrint('table created');
      }).catchError((error) {
        debugPrint('Error when creating table ${error.toString()}');
      });
    }, onOpen: (db) {
      // debugPrint('${db.path} database opened');
      // debugPrint('$db database opened');
      // getDataFromDatabase(database!);
      // database = db;
    })
        .then((value) {
      debugPrint(value.toString());
      database = value;
    });
  }

  /// [addPhotoToFavourites] this function for adding photo to favourite
  Future<void> addPhotoToFavourites({required PhotoModel photoModel}) async {
    await insertToDatabase(photoModel);
    notifyListeners();
  }

  /// [insertToDatabase] this function for handling insertion into database
  Future<void> insertToDatabase(PhotoModel photoModel) async {
    for (var photo in myFavouritePhotos) {
      if (photo.image == photoModel.image) {
        return showToast(
            text: 'This photo already already exist in your cart',
            stateColor: ShowToastColor.error);
      }
    }
    debugPrint(database.toString());
    database!.transaction((txn) async {
      await txn
          .insert(
        tableName,
        photoModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((value) {
        showToast(
            text: 'Added to favourites successfully',
            stateColor: ShowToastColor.success);
        getDataFromDatabase(database!);
      }).catchError((error) {
        debugPrint('Error when inserting new record ${error.toString()}');
      });
    });
  }

  /// [getDataFromDatabase] this function for handling getting data from database
  Future<void> getDataFromDatabase(Database database) async {
    // myFavouritePhotos = [];
    if (myFavouritePhotos.isNotEmpty) {
      debugPrint('length = ${myFavouritePhotos.length}');
    }
    List<Map> maps = await database.query(tableName);
    myFavouritePhotos = maps.isNotEmpty
        ? maps.map((photo) => PhotoModel.fromJson(photo)).toList()
        : [];
    notifyListeners();
  }

  /// [removeFromFavourites] this function for handling deleting from database
  Future<void> removeFromFavourites({required PhotoModel photosModel, required int index}) async {
    await database!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [photosModel.id!],
    ).then((value) async{
      showToast(
          text: 'photo removed successfully',
          stateColor: ShowToastColor.success);
      await getDataFromDatabase(database!);
    });

    notifyListeners();

  }

  /// [deleteDatabaseTable] this function for deleting a table from database
  Future<int> deleteDatabaseTable() async {
    debugPrint('delete All function Called');
    return await database!.delete(tableName);
  }

  /// [downloadImage] this function for download Image from url
  Future<void> downloadImage(String url) async {
    try{
      var imageId = await ImageDownloader.downloadImage(url);
      var path = await ImageDownloader.findPath(imageId!);
      File image = File(path!);

      //open file after download it
      openFile(filePath: image.path);

      downloadedImage = image;

      debugPrint('File path: ${downloadedImage!.path}');

      notifyListeners();
    }catch(error){
      debugPrint(error.toString());
    }
  }

  /// [openFile] this function for open the downloaded Image
  Future openFile({required String filePath}) async {
    OpenFile.open(filePath);
  }

}
