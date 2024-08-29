import 'package:flutter/material.dart';
import '../../data/Models/home_tap_api.dart';

class WatchMovieCard extends StatelessWidget {
  final Movie movie;

  const WatchMovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: height * 0.02),
      width: width * 0.878,
      height: height * 0.15,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.fill,
              width: width  * 0.3,
              height: double.infinity,
            ),
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  movie.releaseDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  movie.overView.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
