
class HomeDataModel {
  HomeDataModel({
      this.page, 
      this.perPage, 
      this.photos, 
      this.totalResults, 
      this.nextPage,});

  HomeDataModel.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(HomeDataPhotos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }
  int? page;
  int? perPage;
  List<HomeDataPhotos>? photos;
  int? totalResults;
  String? nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['per_page'] = perPage;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['total_results'] = totalResults;
    map['next_page'] = nextPage;
    return map;
  }

}


class HomeDataPhotos {

  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  HomeDataSrc? src;
  bool? liked;
  String? alt;

  HomeDataPhotos({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  HomeDataPhotos.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = json['src'] != null ? HomeDataSrc.fromJson(json['src']) : null;
    liked = json['liked'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'width' : width,
      'height' : height,
      'url' : url,
      'photographer' : photographer,
      'photographer_url' : photographerUrl,
      'photographer_id' : photographerId,
      'avg_color' : avgColor,
      'src' : src!.toJson(),
      'liked' : liked,
      'alt' : alt,
    };
  }

}


class HomeDataSrc {

  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  HomeDataSrc({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,});

  HomeDataSrc.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    return {
      'original' : original,
      'large2x' : large2x,
      'large' : large,
      'medium' : medium,
      'small' : small,
      'portrait' : portrait,
      'landscape' : landscape,
      'tiny' : tiny,
    };
  }

}