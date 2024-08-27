import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/screens/SearchTap/models/movie.dart';

Future<void> addMovieToWatchList(Movie movie) async {
  try {
    await FirebaseFirestore.instance.collection('watchlist').add({
      'title': movie.title,
      'year': movie.year,
      'actors': movie.actors,
      'imageUrl': movie.imageUrl,
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
      return Movie(
        title: doc['title'],
        year: doc['year'],
        actors: doc['actors'],
        imageUrl: doc['imageUrl'],
      );
    }).toList();
  });
}
