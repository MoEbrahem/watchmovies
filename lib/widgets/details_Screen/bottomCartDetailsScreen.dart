// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/Models/detailsScreen/LikeMoviesModel.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';
import 'package:movies_app/widgets/details_Screen/imageWithBookMark.dart';

class BottomCartDetailsScreen extends StatelessWidget {
  Results movieDetails;
  BottomCartDetailsScreen({
    super.key,
    required this.movieDetails,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreenView(
                movieId: movieDetails.id!, movieTitle: movieDetails.title!),
          ),
        );
      },
      child: Container(
        width: width * 0.267,
        color: const Color(0xff343534),
        margin: EdgeInsets.only(
          top: width * 0.035,
        ),
        child: Column(
          children: [
            BookMarkImage(
              imagepath: movieDetails.posterPath??'',
              // selectedToWatchList: false,
              imageHeight: height * 0.16,
              imagewidth: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.015),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '⭐ ${movieDetails.voteAverage!.toStringAsFixed(1)}',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    movieDetails.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.whiteColor,
                        ),
                  ),
                  Text(
                    movieDetails.releaseDate!,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
