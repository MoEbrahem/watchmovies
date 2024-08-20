import 'package:flutter/material.dart';
import 'package:movies_app/screens/WatchListTap/MovieCard.dart';
import 'package:movies_app/screens/WatchListTap/models/movie.dart';
import 'package:movies_app/screens/WatchListTap/services/api_service.dart';

class WatchListTap extends StatefulWidget {
  @override
  _WatchListTapState createState() => _WatchListTapState();
}

class _WatchListTapState extends State<WatchListTap> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Watch List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              },
            );
          } else {
            return Center(child: Text('No movies found.'));
          }
        },
      ),
    );
  }
}
