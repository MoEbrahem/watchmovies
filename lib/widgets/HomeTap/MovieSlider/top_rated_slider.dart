import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';

import '../../../data/watchLater/firebase/firebase.dart';

class TopRatedSlider extends StatefulWidget {
  final String label;
  List<Movie> listMovies;

  TopRatedSlider({
    super.key,
    required this.label,
    required this.listMovies,
  });

  @override
  State<TopRatedSlider> createState() => _TopRatedSliderState();
}

class _TopRatedSliderState extends State<TopRatedSlider> {
  final Set<int> selectedIndices = {};

  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: height * 0.365,
          color: AppColors.graylightColor,
          child: Padding(
            padding: EdgeInsets.only(left: height * 0.010, top: height * 0.015),
            child: Stack(
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.042,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      width: width * 0.05,
                    ),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.listMovies.length,
                    itemBuilder: (context, index) {
                      final movie = widget.listMovies[index];
                      final isSelected = selectedIndices.contains(movie.id);

                      return Container(
                        margin: EdgeInsets.only(bottom: width * 0.05),
                        width: width * 0.34,
                        decoration: BoxDecoration(
                          color: AppColors.recommendedContainer,
                          borderRadius: BorderRadius.circular(width*0.04),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsScreenView(
                                  movieId: movie.id,
                                  movieTitle: movie.title,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: width * 0.34,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        filterQuality: FilterQuality.high,
                                        "${ApiConstants.imagePath}${movie.posterPath}",
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: width * 0.23,
                                        bottom: width * 0.255,
                                        left: -18,
                                        child: IconButton(
                                          icon: isSelected
                                              ? Stack(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/bookmark.png",
                                                      color:
                                                          AppColors.goldColor,
                                                      fit: BoxFit.cover,
                                                      width: width * 0.08,
                                                      height: width * 0.1,
                                                    ),
                                                    Positioned(
                                                      top: width * 0.011,
                                                      left: width * 0.013,
                                                      child: Icon(
                                                        Icons.check,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: width * 0.055,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      bottom: -5,
                                                      child: Icon(
                                                        Icons.bookmark,
                                                        color: AppColors
                                                            .bookMarkColor,
                                                        size: width * 0.127,
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: width * 0.014,
                                                        left: width * 0.035,
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 20,
                                                          color: AppColors
                                                              .whiteColor,
                                                        )),
                                                  ],
                                                ),
                                          onPressed: () {
                                            _toggleWatchlist(index, movie);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.009),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset("assets/images/star.png"),
                                          SizedBox(width: width * 0.005),
                                          Text(
                                            movie.voteAverage
                                                .toStringAsFixed(1),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        movie.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: AppColors.whiteColor,
                                            ),
                                      ),
                                      Text(
                                        movie.releaseDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    final allMovies = await getMoviesFromWatchList().first;
    setState(() {
      selectedIndices.addAll(allMovies.map((movie) => movie.id));
    });
  }

  Future<void> _toggleWatchlist(int index, Movie movie) async {
    final isSelected = selectedIndices.contains(movie.id);

    setState(() {
      if (isSelected) {
        selectedIndices.remove(movie.id);
        deleteMovieFromWatchList(movie.title);
      } else {
        selectedIndices.add(movie.id);
        addMovieToWatchList(movie);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSelected
              ? '${movie.title} removed from watchlist'
              : '${movie.title} added to watchlist',
        ),
      ),
    );
  }
}
