import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/screens/HomeTap/Details/details_screen.dart';

class TopRatedSlider extends StatefulWidget {
  final String label;
  final AsyncSnapshot snapshot;

  const TopRatedSlider(
      {super.key, required this.label, required this.snapshot});

  @override
  State<TopRatedSlider> createState() => _TopRatedSliderState();
}

class _TopRatedSliderState extends State<TopRatedSlider> {
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: height * 0.03),
        SizedBox(
          height: height * 0.37,
          child: Container(
            color: AppColors.graylightColor,
            child: Padding(

              padding: EdgeInsets.all(height * 0.010),
              child: Stack(
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(

                    padding: EdgeInsets.only(top: height * 0.03),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.snapshot.data.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedIndices.contains(index);

                        return Padding(

                          padding: EdgeInsets.all(height * 0.010),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [

                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreen(
                                                  snapshot: widget.snapshot,
                                                  movie: widget
                                                      .snapshot.data[index],
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
                                              "${ApiConstants.imagePath}${widget.snapshot.data[index].posterPath}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 110,
                                          bottom: 155,
                                          child: IconButton(
                                            icon: Image.asset(
                                              "assets/images/bookmark.png",
                                              color: isSelected
                                                  ? AppColors.goldColor
                                                  : AppColors.grayColor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (isSelected) {
                                                  _selectedIndices
                                                      .remove(index);
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
                                  SizedBox(height: height * 0.009),
                                  Row(
                                    children: [
                                      Image.asset("assets/images/star.png"),
                                      SizedBox(width: width * 0.005),
                                      Text(
                                        widget.snapshot.data[index].voteAverage
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w100,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 140,
                                    child: Text(
                                      widget.snapshot.data[index].title,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w100,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    widget.snapshot.data[index].releaseDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 12),
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
