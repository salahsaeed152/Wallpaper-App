
class PhotoModel {

  int? id;
  String? image;
  String? isFavourite;


  PhotoModel({
    this.id,
    this.image,
    this.isFavourite,
  });

  PhotoModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'image' : image,
      'isFavourite' : isFavourite,
    };
  }

}
