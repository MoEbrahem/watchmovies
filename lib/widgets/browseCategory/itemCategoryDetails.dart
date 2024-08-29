// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/Models/browseModel/itemsCategoryModel.dart';
import 'package:movies_app/viewModel/browseCategory.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';

class ItemCategoryDetails extends StatelessWidget {
  Results itemResult;
  ItemCategoryDetails({
    super.key,
    required this.itemResult,
  });
  BrowseCategoryViewModel viewModel = BrowseCategoryViewModel();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreenView(
              movieTitle: itemResult.title!,
              movieId: itemResult.id!
            ),
          ),
        );
      },
      child: SizedBox(
        height: height * 0.173,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${itemResult.posterPath}',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  const Icon(
                    Icons.star,
                    color: AppColors.goldColor,
                    size: 41,
                  ),
                  Positioned(
                    left: width * 0.035,
                    top: width * 0.037,
                    child: Text(
                      itemResult.voteAverage!.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: height * 0.015,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    itemResult.title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    itemResult.overview!,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    "(${itemResult.voteCount})",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    itemResult.releaseDate!,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
