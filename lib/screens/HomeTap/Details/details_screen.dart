import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/data/HomeTapAPI/model/home_tap_api.dart';
import 'package:movies_app/screens/HomeTap/home_tap.dart';
import 'package:movies_app/widgets/HomeTap/MovieSlider/up_coming_slider.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.snapshot, required this.movie});

  final Movie movie;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.whiteColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeTab(),
              ),
            );
          },
        ),
        backgroundColor: AppColors.graylightColor,
        title: Text(
          movie.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            filterQuality: FilterQuality.high,
            "${ApiConstants.imagePath}${movie.backDropPath}",
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            movie.title,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Image.network(
                              filterQuality: FilterQuality.high,
                              "${ApiConstants.imagePath}${movie.posterPath}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 140),
                            child: Column(
                              children: [
                                Text(
                                  movie.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 140),
                            child: Column(
                              children: [
                                Text(
                                  movie.releaseDate,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      left: 150,
                      child: Text(
                        movie.overView,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 7,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child:
                      UpComingSlider(label: "Recommended", snapshot: snapshot),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
