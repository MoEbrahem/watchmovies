import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';
import 'package:movies_app/data/watchLater/firebase/firebase.dart';

class BookMarkImage extends StatefulWidget {
  double imageHeight;
  double imagewidth;
  String imagepath;
  bool isSelected;
  String title;
  movieDetailsModel movie;
  BookMarkImage({
    super.key,
    required this.movie,
    required this.imageHeight,
    required this.imagewidth,
    required this.imagepath,
    required this.isSelected,
    required this.title,
  });

  @override
  State<BookMarkImage> createState() => _BookMarkImageState();
}

class _BookMarkImageState extends State<BookMarkImage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        widget.imagepath == ''
            ? Image.network(
                'https://kennyleeholmes.com/wp-content/uploads/2017/09/no-image-available.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: width * 0.32,
              )
            : Image.network(
                'https://image.tmdb.org/t/p/w500${widget.imagepath}',
                fit: BoxFit.fill,
                height: widget.imageHeight,
                width: widget.imagewidth,
              ),
        Positioned(
          top: -14,
          left: -19,
          child: IconButton(
            onPressed: () {
              setState(() {
                if (widget.isSelected == false) {
                  widget.isSelected = true;
                  Movie movie = Movie(
                    id: widget.movie.id!,
                    title: widget.movie.title!,
                    overView: widget.movie.overview!,
                    posterPath: widget.movie.posterPath!,
                    backDropPath: widget.movie.backdropPath!,
                    originalTitle: widget.movie.originalTitle!,
                    releaseDate: widget.movie.releaseDate!,
                    voteAverage: widget.movie.voteAverage!,
                  );
                  addMovieToWatchList(movie);
                } else {
                  widget.isSelected = false;
                  deleteMovieFromWatchList(widget.title);
                }
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(widget.isSelected
                      ? "Movie removed from watchlist"
                      : "Movie added to watchlist"),
                ),
              );
            },
            icon: Stack(
              children: [
                Icon(
                  Icons.bookmark,
                  color: widget.isSelected == false
                      ? AppColors.bookMarkColor
                      : AppColors.goldColor,
                  size: 45,
                ),
                Positioned(
                  top: width * 0.025,
                  left: width * 0.037,
                  child: Icon(
                    widget.isSelected == false ? Icons.add : Icons.check,
                    color: AppColors.whiteColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
