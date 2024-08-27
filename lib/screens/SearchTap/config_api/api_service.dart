import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/screens/SearchTap/models/api_search.dart';
import 'package:movies_app/screens/SearchTap/models/movie.dart';

Future<ApiWatch> addApiSettings() async {
  final apiKey = '62719ca1d744677169a0d4e9e0424a1f';
  final url = 'https://api.themoviedb.org/3/configuration?api_key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return ApiWatch.fromJson(data);
  } else {
    throw Exception('Failed to load API settings');
  }
}

Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
  final apiKey = '62719ca1d744677169a0d4e9e0424a1f';
  final url =
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&append_to_response=credits';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load movie details');
  }
}

String getMovieCast(Map<String, dynamic> movieData) {
  final List<dynamic> cast = movieData['credits']['cast'];
  final actorNames = cast.take(3).map((actor) => actor['name']).join(', ');

  return actorNames.isNotEmpty
      ? actorNames
      : 'Actors information not available';
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

    return Future.wait(moviesData.map<Future<Movie>>((json) async {
      final movieDetails = await getMovieDetails(json['id']);
      return Movie.fromJson(movieDetails, baseUrl, posterSize);
    }).toList());
  } else {
    throw Exception('Failed to load movies');
  }
}
