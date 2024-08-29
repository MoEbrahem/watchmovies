import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/api.dart';
import 'package:movies_app/data/Models/home_tap_api.dart';
import 'package:movies_app/widgets/HomeTap/MovieSlider/popular_slider.dart';
import 'package:movies_app/widgets/HomeTap/MovieSlider/top_rated_slider.dart';
import 'package:movies_app/widgets/HomeTap/MovieSlider/up_coming_slider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> upComingMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = ApiManager().getPopular();
    upComingMovies = ApiManager().getUpComing();
    topRatedMovies = ApiManager().getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(width*0.01),
        child: ListView(
          children: [
            Column(
              children: [
                FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        return PopularSlider(
                          listMovies: snapshot.data!,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                // SizedBox(
                //   height: width*0.0001,
                // ),
                FutureBuilder(
                    future: upComingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        return UpComingSlider(
                          listMovies: snapshot.data!,
                          label: "New Release",
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                SizedBox(
                  height: height*0.02,
                ),
                FutureBuilder(
                  future: topRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return TopRatedSlider(
                        listMovies: snapshot.data!,
                        label: "Recommended",
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               popularSlider(
//                 image: "assets/images/van.png",
//                 nameMovie: "Dora and the Lost City of Gold",
//                 releaseTime: "2019  PG-13  2h 7m",
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               upComingSlider(
//                 label: "New Release",
//                 image: "assets/images/van.png",
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TopRatedSlider(
//                 label: "Recommended",
//                 image: "assets/images/van.png",
//                 rated: "7.7",
//                 movieName: "Van Gogh",
//                 realse: "Time",
//               )
//             ],
//           ),
//         ),
