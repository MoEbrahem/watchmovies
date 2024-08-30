// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';

class PopularSlider extends StatelessWidget {
  PopularSlider({super.key, required this.listMovies,required this.isSelected});
  bool isSelected;
  List<Movie> listMovies;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: listMovies.length,
        options: CarouselOptions(
            aspectRatio: 1.5,
            height: height * 0.4,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 2)),
        itemBuilder: (context, index, pageView) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DetailsScreenView(
                    isSelected: isSelected,
                    movieId: listMovies[index].id,
                    movieTitle: listMovies[index].title,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      filterQuality: FilterQuality.high,
                      "${ApiConstants.imagePath}${listMovies[index].backDropPath}",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(width * 0.045),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        width: width * 0.36,
                        child: Image.network(
                          filterQuality: FilterQuality.high,
                          "${ApiConstants.imagePath}${listMovies[index].posterPath}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: width * 1,
                  height: height * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Play Button
                Positioned(
                  top: height * 0.1,
                  left: width * 0.45,
                  child: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                // Movie Info
                Positioned(
                  bottom: width * 0.08,
                  left: width * 0.05,
                  // right: width*0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: height * 0.195,
                        ),
                        child: Column(
                          children: [
                            Text(listMovies[index].title,
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                          left: height * 0.195,
                        ),
                        child: Column(
                          children: [
                            Text(
                              listMovies[index].releaseDate,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
