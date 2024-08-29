import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';


import '../../../screens/WatchListTap/firebase/firebase.dart';


class UpComingSlider extends StatefulWidget {
  final String label;
  final List<Movie> listMovies;

class UpComingSlider extends StatefulWidget {
  String label;
  List<Movie> listMovies;


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

  final Set<int> _selectedIndices = {};


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

                        final isSelected = selectedIndices.contains(index);

                        final isSelected = _selectedIndices.contains(index);


                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsScreenView(

                                                movieId:
                                                widget.listMovies[index].id,
                                                movieTitle:
                                                widget.listMovies[index].title,
                                              ),
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
                                        ],
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (isSelected) {
                                            selectedIndices.remove(index);
                                            deleteMovieFromWatchList(
                                                widget.listMovies[index].title);
                                          } else {
                                            selectedIndices.add(index);
                                            addMovieToWatchList(
                                                widget.listMovies[index]);
                                          }
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(isSelected
                                                ? "Movie removed from watchlist"
                                                : "Movie added to watchlist"),
                                          ),
                                        );

                                              children: [
                                                Image.asset(
                                                  "assets/images/bookmark.png",
                                                  color: AppColors.goldColor,
                                                  fit: BoxFit.cover,
                                                  width: width * 0.069,
                                                  height: height * 0.05,
                                                ),
                                                Positioned(
                                                  top: width*0.011,
                                                  left: width*0.009,
                                                  child: Icon(
                                                    Icons.check,
                                                    color: AppColors.whiteColor,
                                                    size: width * 0.055,
                                                  ),
                                                )
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
                                                  top: width * 0.018,
                                                  left: width * 0.038,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColors.whiteColor,
                                                    size: width * 0.055,
                                                  ),
                                                )
                                              ],
                                            ),
                                      onPressed: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedIndices.remove(index);
                                          } else {
                                            _selectedIndices.add(index);
                                          }
                                        });

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
}
