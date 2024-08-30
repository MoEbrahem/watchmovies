import 'package:flutter/material.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';
import 'package:movies_app/viewModel/detailsScreen.dart';
import 'package:movies_app/widgets/details_Screen/imageWithBookMark.dart';

import '../../constants/color.dart';

class Movie_content extends StatefulWidget {
  bool isSelected;
  movieDetailsModel movieDetails;
  
  int movieId;

  Movie_content({
    super.key,
    required this.isSelected,
    required this.movieDetails,
    required this.movieId,
  });

  @override
  State<Movie_content> createState() => _Movie_contentState();
}

class _Movie_contentState extends State<Movie_content> {
  DetailsScreenViewModel viewModel = DetailsScreenViewModel();
  @override
  void initState() {
    super.initState();
    if(viewModel.movieDetails == null){
    viewModel.getMovieDetails(widget.movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: BookMarkImage(
            movie: widget.movieDetails,
            title: widget.movieDetails.title!,
            isSelected: widget.isSelected,
            imageHeight: height * 0.23,
            imagewidth: width * 0.34,
            imagepath: widget.movieDetails.posterPath!,
          ),
        ),
        SizedBox(
          width: width * 0.04,
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * 0.04,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.movieDetails.genres!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: width * 0.03),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.045, vertical: width * 0.015),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.grayColor)),
                      child: Text(
                        widget.movieDetails.genres![index].name!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Text(
                widget.movieDetails.overview!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.grayColor),
                maxLines: 4,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text('⭐ ${widget.movieDetails.voteAverage!.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        )
      ],
    );
  }
}
