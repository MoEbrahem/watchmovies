// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/data/Models/browseModel/categoryModel.dart';

class ItemCategory extends StatelessWidget {
  String imageurl;
  CategoryDetails categoryDetails;

  ItemCategory({
    super.key,
    required this.categoryDetails,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageurl,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: const Color(0xff343534).withOpacity(0.5),
        ),
        Center(
          child: Text(
            categoryDetails.name ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }
}
