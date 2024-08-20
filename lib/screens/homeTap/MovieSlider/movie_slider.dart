import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';

class MovieSlider extends StatelessWidget {
  String label;

  MovieSlider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 180,
          width: 140,
          child: Container(
            color: AppColors.graylightColor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (contex, Index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      color: Colors.white,
                      height: 180,
                      width: 140,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
