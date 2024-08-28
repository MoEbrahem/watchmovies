import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/screens/SearchTap/models/movie.dart';
import 'package:movies_app/screens/WatchListTap/firebase_ListWatch/firebase.dart';

import '../../widget/MovieCard/MovieCard.dart';

class WatchListTap extends StatefulWidget {
  @override
  State<WatchListTap> createState() => _WatchListTapState();
}

class _WatchListTapState extends State<WatchListTap> {
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
      body: StreamBuilder<List<Movie>>(
        stream: getMoviesFromWatchList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            final movies = snapshot.data!;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(movies[index].title),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          if (index >= 0 && index < movies.length) {
                            String movieTitle = movies[index].title;
                            deleteMovieFromWatchList(movieTitle);
                            setState(() {
                              movies.removeAt(index);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("$movieTitle removed from watchlist"),
                              ),
                            );
                          }
                        },
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors.goldColor,
                        icon: Icons.delete,
                        label: 'Delete',
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Stack(
                      children: [
                        MovieCard(movie: movies[index]),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.0001,
                          left: MediaQuery.of(context).size.width * 0.0001,
                          child: const ImageIcon(
                            AssetImage('assets/images/bookmark.png'),
                            color: AppColors.goldColor,
                            size: 35,
                          ),
                        ),
                        Positioned(
                          child: Icon(
                            Icons.check,
                            size: 18,
                            color: AppColors.whiteColor,
                          ),
                          top: MediaQuery.of(context).size.height * 0.010,
                          left: MediaQuery.of(context).size.width * 0.014,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
