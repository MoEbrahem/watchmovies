import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';

class ApiManager {
  static const _popular =
      "https://${ApiConstants.baseUrl}${ApiConstants.popularMovie}?api_key=${ApiConstants.apiKey}";
  static const _upComing =
      "https://${ApiConstants.baseUrl}${ApiConstants.upComingMovie}?api_key=${ApiConstants.apiKey}";
  static const _topRated =
      "https://${ApiConstants.baseUrl}${ApiConstants.topRatedMovie}?api_key=${ApiConstants.apiKey}";

  Future<List<Movie>> getPopular() async {
    final response = await http.get(Uri.parse(_popular));
    if (response.statusCode == 200) {
      final decodDate = json.decode(response.body)['results'] as List;
      print("Success popular Api");
      return decodDate.map((popular) => Movie.fromJson(popular)).toList();
    } else {
      throw Exception("Something Wrong");
    }
  }

  Future<List<Movie>> getUpComing() async {
    final response = await http.get(Uri.parse(_upComing));
    if (response.statusCode == 200) {
      final decodDate = json.decode(response.body)['results'] as List;
      print("Success upComing Api");
      return decodDate.map((popular) => Movie.fromJson(popular)).toList();
    } else {
      throw Exception("Something Wrong");
    }
  }

  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(_topRated));
    if (response.statusCode == 200) {
      final decodDate = json.decode(response.body)['results'] as List;
      print("Success topRated Api");
      return decodDate.map((popular) => Movie.fromJson(popular)).toList();
    } else {
      throw Exception("Something Wrong");
    }
  }
}
