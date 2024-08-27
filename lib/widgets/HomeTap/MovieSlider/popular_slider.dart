import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/screens/HomeTap/Details/details_screen.dart';

class PopularSlider extends StatelessWidget {
  const PopularSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
              aspectRatio: 1.5,
              height: MediaQuery.of(context).size.height * 0.4,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 2)),
          itemBuilder: (context, Index, pageView) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                          snapshot: snapshot,
                          movie: snapshot.data[Index],
                        )));
              },
              child: Container(
                color: AppColors.graylightColor,
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                          filterQuality: FilterQuality.high,
                          "${ApiConstants.imagePath}${snapshot.data[Index].backDropPath}",
                          fit: BoxFit.cover),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: Image.network(
                            filterQuality: FilterQuality.high,
                            "${ApiConstants.imagePath}${snapshot.data[Index].posterPath}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
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
                  const Positioned(
                    top: 80,
                    left: 165,
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                  // Movie Info
                  Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 150,
                          ),
                          child: Column(
                            children: [
                              Text(snapshot.data[Index].title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 150,
                          ),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data[Index].releaseDate,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
        ));
  }
}
