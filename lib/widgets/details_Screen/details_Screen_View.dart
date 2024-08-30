import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/screens/HomeTap/home_tap.dart';
import 'package:movies_app/screens/homeScreen.dart';
import 'package:movies_app/viewModel/detailsScreen.dart';
import 'package:movies_app/widgets/details_Screen/TopVideoTrailer.dart';
import 'package:movies_app/widgets/details_Screen/bottomCartDetailsScreen.dart';
import 'package:movies_app/widgets/details_Screen/movieUpperContent.dart';
import 'package:provider/provider.dart';

class DetailsScreenView extends StatefulWidget {
  int movieId;
  String movieTitle;
  bool isSelected;
  DetailsScreenView({
    super.key,
    required this.movieId,
    required this.movieTitle,
    this.isSelected = false,
  });

  @override
  State<DetailsScreenView> createState() => _DetailsScreenViewState();
}

class _DetailsScreenViewState extends State<DetailsScreenView> {
  DetailsScreenViewModel viewModel = DetailsScreenViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.getMovieDetails(widget.movieId);
    viewModel.getMoreLikeMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movieTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            )),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<DetailsScreenViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.errMessage != null) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      viewModel.errMessage!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    MaterialButton(
                      onPressed: () {
                        viewModel.getMovieDetails(widget.movieId);
                      },
                      child: Text(
                        "Try Again...",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                ),
              );
            } else if (viewModel.movieDetails == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.goldColor,
                ),
              );
            } else {
              return PopScope(
                canPop:
                    false, //When false, blocks the current route from being popped.
                onPopInvoked: (didPop) {
                  //do your logic here:
                  // AlertDialog(
                  //   title: Text(
                  //     'Do you really want to exit?',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodySmall
                  //         ?.copyWith(color: AppColors.whiteColor),
                  //   ),
                  //   actions: [
                  //     TextButton(
                  //         onPressed: () {
                  //           exit(0);
                  //         },
                  //         child: Text("Yes")),
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Text("No")),
                  //   ],
                  // );
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TopVideoTrailer(
                        imagePath:
                            'https://image.tmdb.org/t/p/w500${viewModel.movieDetails!.backdropPath!}',
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      MovieUpperContent(
                          isSelected: widget.isSelected,
                          movieDetails: viewModel.movieDetails!,
                          movieId: widget.movieId),
                      Container(
                        color: const Color(0xff282A28),
                        margin: EdgeInsets.only(
                          top: width * 0.05,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: width * 0.035,
                          horizontal: width * 0.035,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "More like this",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            viewModel.likeMovies != null
                                ? SizedBox(
                                    height: height * 0.278,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: width * 0.04,
                                      ),
                                      itemCount:
                                          viewModel.likeMovies!.results!.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return BottomCartDetailsScreen(
                                          movie: viewModel.movieDetails!,
                                          movieDetails: viewModel
                                              .likeMovies!.results![index],
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
