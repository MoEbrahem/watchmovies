import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/constants/ApiConstants.dart';
import 'package:movies_app/data/Models/browseModel/categoryModel.dart';
import 'package:movies_app/data/Models/browseModel/itemsCategoryModel.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';

// 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=28'

// base url for images https://image.tmdb.org/t/p/w500/

class ApiManager {
  static Future<movieDetailsModel?>? getmoviesDetails(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.baseurl,
      '/3/movie/$movieId',
      {
        'api_key': '81b8e20dee35c380e6f0fd57898ec3fd',
        'language':'en-US',
      },
    );
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      print(movieId);
      return movieDetailsModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<CategoryModel?>? getCategories() async {
    Uri categoriesurl = Uri.https(
      ApiConstants.baseurl,
      ApiConstants.browseCategories,
      {
        'api_key': '81b8e20dee35c380e6f0fd57898ec3fd',
      },
    );
    try {
      var response = await http.get(categoriesurl);
      var json = jsonDecode(response.body);
      return CategoryModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<ItemsCategoryModel?>? getMoviesByCatergoryId(
      String categoryId, String page) async {
    Uri url = Uri.https(
      ApiConstants.baseurl,
      ApiConstants.unencodedPath,
      {
        'api_key': '81b8e20dee35c380e6f0fd57898ec3fd',
        "include_adult": "false",
        "include_video": "false",
        "language": "en-US",
        "page": page,
        "sort_by": "popularity.desc",
        "with_genres": categoryId,
      },
    );
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return ItemsCategoryModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
