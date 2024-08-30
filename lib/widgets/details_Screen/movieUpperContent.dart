import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';
import 'package:movies_app/widgets/details_Screen/movie_content.dart';

class MovieUpperContent extends StatefulWidget {
  movieDetailsModel movieDetails;
  bool isSelected;
  int? movieId;
  MovieUpperContent({
    super.key,
    required this.isSelected,
    required this.movieDetails,
    required this.movieId,
  });

  @override
  State<MovieUpperContent> createState() => _MovieUpperContentState();
}

class _MovieUpperContentState extends State<MovieUpperContent> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.movieDetails.title!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            widget.movieDetails.releaseDate!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.grayColor),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Movie_content(
            isSelected:widget.isSelected,
            movieDetails: widget.movieDetails,
            movieId: widget.movieId!,
          ),
        ],
      ),
    );
  }
}
