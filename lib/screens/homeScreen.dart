// ignore_for_file: file_names, constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/screens/BrowseTap/browse_tap.dart';
import 'package:movies_app/screens/HomeTap/home_tap.dart';
import 'package:movies_app/screens/SearchTap/search_tap.dart';
import 'package:movies_app/screens/WatchListTap/watch_list_tap.dart';
import 'package:movies_app/viewModel/browseCategory.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route_Name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selctedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        currentIndex: selctedItem,
        onTap: (index) {
          selctedItem = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            // backgroundColor: AppColors.primaryColor,
            label: "Home",
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
            ),
          ),
          BottomNavigationBarItem(
            // backgroundColor: AppColors.primaryColor,
            label: "Search",
            icon: ImageIcon(
              AssetImage("assets/images/search.png"),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            label: "Browse",
            icon: ImageIcon(
              AssetImage("assets/images/browse.png"),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryColor,
            label: "Watch List",
            icon: ImageIcon(
              AssetImage("assets/images/watchlist.png"),
            ),
          ),
        ],
      ),
      body: tabs[selctedItem],
    );
  }

  List<Widget> tabs = [
     HomeTab(),
    SearchTap(),
    ChangeNotifierProvider(
      create: (context) => BrowseCategoryViewModel(),
      child: const BrowseTap(),
    ),
    WatchListTap()
  ];
}
