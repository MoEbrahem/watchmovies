// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';


class BookMarkImage extends StatefulWidget {
  double imageHeight;
  double imagewidth;
  String imagepath;
  BookMarkImage({
    super.key,
    required this.imageHeight,
    required this.imagewidth,
    required this.imagepath,
  });

  @override
  State<BookMarkImage> createState() => _BookMarkImageState();
}

class _BookMarkImageState extends State<BookMarkImage> {
  bool selectedToWatchList = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        widget.imagepath == ''
            ? Image.network(
                'https://kennyleeholmes.com/wp-content/uploads/2017/09/no-image-available.png',fit: BoxFit.fill,width: double.infinity,height: width*0.32,)
            : Image.network(
                'https://image.tmdb.org/t/p/w500${widget.imagepath}',
                fit: BoxFit.fill,
                height: widget.imageHeight,
                width: widget.imagewidth,
              ),
        Positioned(
          top: -14,
          left: -19,
          child: IconButton(
            onPressed: () {
              setState(() {
                if (selectedToWatchList == false) {
                  selectedToWatchList = true;
                } else {
                  selectedToWatchList = false;
                }
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(selectedToWatchList
                      ? "Movie removed from watchlist"
                      : "Movie added to watchlist"),
                ),
              );
              
            },
            icon: Stack(
              children: [
                Icon(
                  Icons.bookmark,
                  color: selectedToWatchList == false
                      ? AppColors.bookMarkColor
                      : AppColors.goldColor,
                  size: 45,
                ),
                Positioned(
                  top: width * 0.025,
                  left: width * 0.037,
                  child: Icon(
                    selectedToWatchList == false ? Icons.add : Icons.check,
                    color: AppColors.whiteColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
