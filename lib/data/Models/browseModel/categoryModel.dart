// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  List<CategoryDetails>? categories;
  String? status_code;
  String? status_message; 
  bool? success;

  CategoryModel({this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status_code = json['status_code'];
    success = json['success'];
    status_message = json['status_message'];
    if (json['genres'] != null) {
      categories = <CategoryDetails>[];
      json['genres'].forEach((v) {
        categories!.add(CategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['genres'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  int? id;
  String? name;

  CategoryDetails({this.id, this.name});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
