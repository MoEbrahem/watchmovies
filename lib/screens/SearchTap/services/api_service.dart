import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/screens/SearchTap/models/api_watch.dart';
import 'package:movies_app/screens/SearchTap/models/movie.dart';

Future<ApiWatch> addApiSettings() async {
  const  apiKey = '62719ca1d744677169a0d4e9e0424a1f';
  const url = 'https://api.themoviedb.org/3/configuration?api_key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return ApiWatch.fromJson(data);
  } else {
    throw Exception('Failed to load API settings');
  }
}

Future<List<Movie>> importMovieFromApi({String query = ''}) async {
  final apiKey = '62719ca1d744677169a0d4e9e0424a1f';
  final settings = await addApiSettings();

  final url = query.isEmpty
      ? 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'
      : 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List moviesData = data['results'];
    final baseUrl = settings.images?.secureBaseUrl ?? '';
    final posterSize = 'w500';

    return moviesData
        .map<Movie>((json) => Movie.fromJson(json, baseUrl, posterSize))
        .toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

void searchForMovies(String query) async {
  final movies = await importMovieFromApi(query: query);
}
