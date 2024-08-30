import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/screens/BrowseTap/listItemCategoryDetails.dart';
import 'package:movies_app/viewModel/browseCategory.dart';
import 'package:movies_app/widgets/browseCategory/itemCategory.dart';
import 'package:provider/provider.dart';

class BrowseTap extends StatefulWidget {
  const BrowseTap({super.key});

  @override
  State<BrowseTap> createState() => _BrowseTapState();
}

class _BrowseTapState extends State<BrowseTap> {
  BrowseCategoryViewModel categoryViewModel = BrowseCategoryViewModel();
  @override
  void initState() {
    super.initState();
    if (categoryViewModel.listCategories == null) {
      categoryViewModel.getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
        top: height * 0.08,
        left: height*0.008
      ),
      padding: EdgeInsets.all(
        height * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Browse Category",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ChangeNotifierProvider(
            create: (context) => categoryViewModel,
            child: Consumer<BrowseCategoryViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.errMessage != null) {
                  return Column(
                    children: [
                      Text(
                        viewModel.errMessage!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      MaterialButton(
                        onPressed: () {
                          viewModel.getCategories();
                        },
                        child: Text(
                          "Try Again...",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      )
                    ],
                  );
                } else if (viewModel.listCategories == null) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.goldColor,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: height * 0.05,
                          mainAxisSpacing: height * 0.05,
                          mainAxisExtent: height * 0.125),
                      itemCount: 18,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ListItemCategoryDetails(
                                  category: viewModel.listCategories![index],
                                ),
                              ),
                            );
                          },
                          child: ItemCategory(
                            imageurl: viewModel.categoriesImages[index],
                            categoryDetails: viewModel.listCategories![index],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

