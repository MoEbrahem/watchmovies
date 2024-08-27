import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/HomeTapAPI/api/ApiConstants.dart';
import 'package:movies_app/screens/HomeTap/Details/details_screen.dart';

class UpComingSlider extends StatefulWidget {
  String label;

  UpComingSlider({super.key, required this.label, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  State<UpComingSlider> createState() => _UpComingSliderState();
}

class _UpComingSliderState extends State<UpComingSlider> {
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.35,
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
                      itemCount: widget.snapshot.data!.length,
                      itemBuilder: (context, index) {
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
                                                  DetailsScreen(
                                                    snapshot: widget.snapshot,
                                                    movie: widget
                                                        .snapshot.data[index],
                                                  )));
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.24,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Image.network(
                                        filterQuality: FilterQuality.high,
                                        "${ApiConstants.imagePath}${widget.snapshot.data![index].posterPath!}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 110,
                                    bottom: 165,
                                    child: IconButton(
                                      icon: Image.asset(
                                          "assets/images/bookmark.png",
                                          color: isSelected
                                              ? AppColors.goldColor
                                              : AppColors.grayColor),
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
