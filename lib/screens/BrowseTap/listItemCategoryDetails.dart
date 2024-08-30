// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/Models/browseModel/categoryModel.dart';
import 'package:movies_app/viewModel/browseCategory.dart';
import 'package:movies_app/widgets/browseCategory/itemCategoryDetails.dart';
import 'package:provider/provider.dart';

class ListItemCategoryDetails extends StatefulWidget {
  static String route_Name = 'ItemCategoryDetails';
  CategoryDetails category;

  ListItemCategoryDetails({
    super.key,
    required this.category,
  });

  @override
  State<ListItemCategoryDetails> createState() =>
      _ListItemCategoryDetailsState();
}

class _ListItemCategoryDetailsState extends State<ListItemCategoryDetails> {
  String page = '1';
  BrowseCategoryViewModel viewModel = BrowseCategoryViewModel();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    viewModel.getItemsCategory(widget.category.id.toString(), page);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        title: Text(
          widget.category.name!,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<BrowseCategoryViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.itemErrorMessage != null) {
              return Column(
                children: [
                  Text(viewModel.itemErrorMessage!),
                  MaterialButton(
                    onPressed: () {
                      viewModel.getItemsCategory(
                          widget.category.id.toString(), page);
                    },
                    child: const Text("Try Again..."),
                  ),
                ],
              );
            } else if (viewModel.listItemsCategory == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.goldColor,
                ),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: width*0.02,
                  bottom: width*0.02,
                  right: width*0.01,
                  left: width*0.03,
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.grayColor,
                  thickness: 1,
                ),
                controller: scrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: width*0.01),
                    child: ItemCategoryDetails(
                      itemResult: viewModel.listItemsCategory![index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      int newpage = int.parse(page) + 1;

      if (newpage <= 500) {
        setState(
          () {
            page = newpage.toString();
            viewModel.getItemsCategory(widget.category.id.toString(), page);
          },
        );
      }
    }
    if (scrollController.position.minScrollExtent ==
        scrollController.position.pixels) {
      int newpage = int.parse(page) - 1;
      if (newpage >= 1) {
        setState(
          () {
            page = newpage.toString();
            viewModel.getItemsCategory(widget.category.id.toString(), page);
          },
        );
      }
    }
  }
}
