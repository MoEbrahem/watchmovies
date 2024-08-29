// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import '../../constants/color.dart';
import '../../data/Models/home_tap_api.dart';
import '../../widgets/watchlist/WatchMovieCard.dart';
import 'firebase/firebase.dart';

import 'package:movies_app/constants/color.dart';
import 'package:movies_app/screens/SearchTap/models/movie.dart';
import 'package:movies_app/widgets/watchlist/MovieCard.dart';


class WatchListTap extends StatefulWidget {
  @override
  _WatchListTapState createState() => _WatchListTapState();
}

class _WatchListTapState extends State<WatchListTap> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Watch List",

          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: StreamBuilder<List<Movie>>(
        stream: getMoviesFromWatchList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.', style: TextStyle(color: AppColors.whiteColor)));
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
                        onPressed: (context) async {
                          String movieTitle = movies[index].title;
                          await deleteMovieFromWatchList(movieTitle);

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
                    child: WatchMovieCard(movie: movies[index]),
                  ),
                );
              },
            );
          }

          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context,index)=> const Divider(thickness: 1,),
        itemCount: movies.length,
        padding: EdgeInsets.only(
                  top: width*0.04,
                  bottom: width*0.04,
                  right: width*0.04,
                  left: width*0.04,
                ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              MovieCard(movie: movies[index]),
              Positioned(
                top: height * 0.005,
                left: -4,
                child: const ImageIcon(
                  AssetImage('assets/images/bookmark.png'),
                  color: AppColors.goldColor,
                  size: 35,
                ),
              ),
              Positioned(
                top: height * 0.010,
                left: width * 0.010,
                child: const Icon(
                  Icons.check,
                  size: 18,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}
