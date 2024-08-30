import 'package:flutter/material.dart';

class TopVideoTrailer extends StatelessWidget {
  String imagePath;

  TopVideoTrailer({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Image.network(
          imagePath,
          fit: BoxFit.fill,
          width: double.infinity,
          height: height * 0.29,
        ),
        Positioned(
          bottom: width * 0.2,
          left: width * 0.45,
          child: const Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: 50,
          ),
        ),
      ],
    );
  }
}
