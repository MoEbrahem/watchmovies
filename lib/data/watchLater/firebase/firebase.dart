import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/home_tap_api.dart';

Future<void> addMovieToWatchList(Movie movie) async {
  try {
    await FirebaseFirestore.instance.collection('watchlist').add({
      'title': movie.title,
      'backDropPath': movie.backDropPath,
      'originalTitle': movie.originalTitle,
      'overView': movie.overView,
      'posterPath': movie.posterPath,
      'releaseDate': movie.releaseDate,
      'voteAverage': movie.voteAverage,
    });
  } catch (e) {
    throw Exception('Failed to add movie: $e');
  }
}

Future<void> deleteMovieFromWatchList(String title) async {
  try {
    var collection = FirebaseFirestore.instance.collection('watchlist');
    var snapshot = await collection.where('title', isEqualTo: title).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    throw Exception('Failed to delete movie: $e');
  }
}

Stream<List<Movie>> getMoviesFromWatchList() {
  return FirebaseFirestore.instance
      .collection('watchlist')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Movie(
        id: int.tryParse(doc.id) ?? 0,
        title: data['title'] ?? '',
        backDropPath: data['backDropPath'] ?? '',
        originalTitle: data['originalTitle'] ?? '',
        overView: data['overView'] ?? '',
        posterPath: data['posterPath'] ?? '',
        releaseDate: data['releaseDate'] ?? '',
        voteAverage: (data['voteAverage'] ?? 0.0) as double,
      );
    }).toList();
  });
}
