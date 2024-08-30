class ApiWatch {
  ApiWatch({
    this.images,
    this.changeKeys,
  });

  ApiWatch.fromJson(dynamic json) {
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    changeKeys =
        json['change_keys'] != null ? json['change_keys'].cast<String>() : [];
  }

  Images? images;
  List<String>? changeKeys;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images?.toJson();
    }
    map['change_keys'] = changeKeys;
    return map;
  }
}

class Images {
  Images({
    this.baseUrl,
    this.secureBaseUrl,
    this.backdropSizes,
    this.logoSizes,
    this.posterSizes,
    this.profileSizes,
    this.stillSizes,
  });

  Images.fromJson(dynamic json) {
    baseUrl = json['base_url'];
    secureBaseUrl = json['secure_base_url'];
    backdropSizes = json['backdrop_sizes'] != null
        ? json['backdrop_sizes'].cast<String>()
        : [];
    logoSizes =
        json['logo_sizes'] != null ? json['logo_sizes'].cast<String>() : [];
    posterSizes =
        json['poster_sizes'] != null ? json['poster_sizes'].cast<String>() : [];
    profileSizes = json['profile_sizes'] != null
        ? json['profile_sizes'].cast<String>()
        : [];
    stillSizes =
        json['still_sizes'] != null ? json['still_sizes'].cast<String>() : [];
  }

  String? baseUrl;
  String? secureBaseUrl;
  List<String>? backdropSizes;
  List<String>? logoSizes;
  List<String>? posterSizes;
  List<String>? profileSizes;
  List<String>? stillSizes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['base_url'] = baseUrl;
    map['secure_base_url'] = secureBaseUrl;
    map['backdrop_sizes'] = backdropSizes;
    map['logo_sizes'] = logoSizes;
    map['poster_sizes'] = posterSizes;
    map['profile_sizes'] = profileSizes;
    map['still_sizes'] = stillSizes;
    return map;
  }
}
