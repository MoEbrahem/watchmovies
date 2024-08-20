import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/screens/homeTap/MovieSlider/movie_slider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider.builder(
                  itemCount: 20,
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return Container(
                      height: MediaQuery.of(context).size.height *
                          0.1, //height: 289
                      width:
                          MediaQuery.of(context).size.width * 0.5, //width: 412
                      color: AppColors.whiteColor,
                    );
                  },
                  options: CarouselOptions(
                      height: 289,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      viewportFraction: 0.55)),
              SizedBox(
                height: 10,
              ),
              MovieSlider(label: "New Releases "),
              SizedBox(
                height: 10,
              ),
              MovieSlider(label: "Recomended")
            ],
          ),
        ),
      ),
    );
  }
}
