class FacebookModel {
  final String? name;
  final String? email;
  final String? id;
  final FacebookPhotoModel? facebookPhotoModel;

  FacebookModel({
    this.name,
    this.email,
    this.id,
    this.facebookPhotoModel,
  });

  factory FacebookModel.fromJson(Map<String, dynamic> data) {
    return FacebookModel(
      email: data['email'],
      id: data['id'],
      name: data['name'],
      facebookPhotoModel: FacebookPhotoModel.fromJson(data['picture']['data']),
    );
  }
}

class FacebookPhotoModel {
  final String? url;
  final int? height;
  final int? width;

  FacebookPhotoModel({
    this.url,
    this.height,
    this.width,
  });

  factory FacebookPhotoModel.fromJson(Map<String, dynamic> data) {
    return FacebookPhotoModel(
      url: data['url'],
      height: data['height'],
      width: data['width'],
    );
  }
}
