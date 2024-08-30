import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';
import 'package:movies_app/data/watchLater/firebase/firebase.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';


class UpComingSlider extends StatefulWidget {
  final String label;
  final List<Movie> listMovies;

  UpComingSlider({
    super.key,
    required this.label,
    required this.listMovies,
  });

  @override
  State<UpComingSlider> createState() => _UpComingSliderState();
}

class _UpComingSliderState extends State<UpComingSlider> {
  final Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: height * 0.3,
          width: width * 0.35,
          child: Container(
            color: AppColors.graylightColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.listMovies.length,
                      itemBuilder: (context, index) {
                      final movie = widget.listMovies[index];
                      final isSelected = selectedIndices.contains(movie.id);

                        return Padding(
                          padding: EdgeInsets.all(width*0.021),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width*0.015),
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsScreenView(
                                                isSelected: isSelected,
                                            movieId:
                                                widget.listMovies[index].id,
                                            movieTitle:
                                                widget.listMovies[index].title,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: height * 0.24,
                                      width: width * 0.35,
                                      child: Image.network(
                                        filterQuality: FilterQuality.high,
                                        "${ApiConstants.imagePath}${widget.listMovies[index].posterPath}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -11,
                                    right: width * 0.23,
                                    bottom: width * 0.339,
                                    left: -19,
                                    child: IconButton(
                                      icon: isSelected
                                          ? Stack(
                                              children: [
                                                Image.asset(
                                                  "assets/images/bookmark.png",
                                                  color: AppColors.goldColor,
                                                  fit: BoxFit.cover,
                                                  width: width * 0.069,
                                                  height: height * 0.05,
                                                ),
                                                Positioned(
                                                  top: width * 0.011,
                                                  left: width * 0.009,
                                                  child: Icon(
                                                    Icons.check,
                                                    color: AppColors.whiteColor,
                                                    size: width * 0.055,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Stack(
                                              children: [
                                                Positioned(
                                                  left: 1,
                                                  bottom: -1,
                                                  child: Icon(
                                                    Icons.bookmark,
                                                    color:
                                                        AppColors.bookMarkColor,
                                                    size: width * 0.127,
                                                  ),
                                                ),
                                                Positioned(
                                                    top: width * 0.02,
                                                    left: width * 0.038,
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color:
                                                          AppColors.whiteColor,
                                                    )),
                                              ],
                                            ),
                                      onPressed: () async {
                                        // setState(() {
                                        //   if (isSelected) {
                                        //     selectedIndices.remove(index);
                                        //     deleteMovieFromWatchList(
                                        //         widget.listMovies[index].title);
                                        //   } else {
                                        //     selectedIndices.add(index);
                                        //     addMovieToWatchList(
                                        //       widget.listMovies[index],
                                        //     );
                                        //   }
                                        // });
                                        _toggleWatchlist(index, movie);      
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(isSelected
                                        //         ? "Movie removed from watchlist"
                                        //         : "Movie added to watchlist"),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ],
    );
  }

  Future<void> _loadInitialData() async {
    for (int index = 0; index < widget.listMovies.length; index++) {
      bool isInWatchlist =
          await isMovieInWatchList(widget.listMovies[index].title);
      if (isInWatchlist) {
        setState(() {
          selectedIndices.add(widget.listMovies[index].id);
        });
      }
    }
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
