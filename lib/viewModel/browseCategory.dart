import 'package:flutter/material.dart';
import 'package:movies_app/data/ApiManager.dart';
import 'package:movies_app/data/Models/browseModel/categoryModel.dart';
import 'package:movies_app/data/Models/browseModel/itemsCategoryModel.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';

class BrowseCategoryViewModel extends ChangeNotifier {
  List<CategoryDetails>? listCategories;
  List<Results>? listItemsCategory;
  String? itemErrorMessage;
  String? errMessage;

  List<String> categoriesImages = [
    'https://www.tidbitsofexperience.com/wp-content/uploads/2023/06/John-Wick-4-poster-1086x1536.jpg',
    'https://i.ebayimg.com/images/g/hscAAOSwL3RiHLd9/s-l1200.jpg',
    'https://1.bp.blogspot.com/-SfMNGaa5yuc/X6niaLnY1kI/AAAAAAAAG0g/-QKEl19KjtsCj-FH_beFk4pSk-EdJTaDACLcBGAsYHQ/s600/httyd%2Bjohn%2Bpowell%2B5%2Bflying.jpg',
    'https://artchatterblog.files.wordpress.com/2014/02/movieposter.jpg',
    'https://media2.firstshowing.net/firstshowing/img10/Darkcrimescarreypostermainfull5991.jpg',
    'https://cdn.designcrowd.com/blog/2017/February/movie-posters/28_600.jpg',
    "https://www.top10about.com/wp-content/uploads/2020/06/The-GodFather-700x491.jpg",
    'https://m.media-amazon.com/images/M/MV5BMjBlYzgzMzAtYTVmYi00YzRlLWFkMGQtMDNlOGI0YTI5OTE4XkEyXkFqcGdeQXVyNTI5NjIyMw@@._V1_FMjpg_UX1000_.jpg',
    'https://www.cinema9jaent.com/wp-content/uploads/Capture-254.png',
    'https://usercontent2.hubstatic.com/14483345_f520.jpg',
    'https://1.bp.blogspot.com/-SfMNGaa5yuc/X6niaLnY1kI/AAAAAAAAG0g/-QKEl19KjtsCj-FH_beFk4pSk-EdJTaDACLcBGAsYHQ/s600/httyd%2Bjohn%2Bpowell%2B5%2Bflying.jpg',
    'https://artchatterblog.files.wordpress.com/2014/02/movieposter.jpg',
    'https://media2.firstshowing.net/firstshowing/img10/Darkcrimescarreypostermainfull5991.jpg',
    'https://cdn.designcrowd.com/blog/2017/February/movie-posters/28_600.jpg',
    "https://www.top10about.com/wp-content/uploads/2020/06/The-GodFather-700x491.jpg",
    'https://m.media-amazon.com/images/M/MV5BMjBlYzgzMzAtYTVmYi00YzRlLWFkMGQtMDNlOGI0YTI5OTE4XkEyXkFqcGdeQXVyNTI5NjIyMw@@._V1_FMjpg_UX1000_.jpg',
    'https://www.cinema9jaent.com/wp-content/uploads/Capture-254.png',
    'https://usercontent2.hubstatic.com/14483345_f520.jpg',
  ];
  getCategories() async {
    try {
      var response = await ApiManager.getCategories();
      if (response!.success != null && response.success == false) {
        errMessage = response.status_message;
      } else if (response.categories != null) {
        listCategories = response.categories;
      }
    } catch (e) {
      errMessage = e.toString();
    }
    notifyListeners();
  }

  getItemsCategory(String categoryId, String page) async {
    itemErrorMessage = null;
    listItemsCategory = null;
    notifyListeners();
    try {
      var res = await ApiManager.getMoviesByCatergoryId(categoryId, page);
      if (res?.errMessage != null && res?.success == 'false') {
        itemErrorMessage = res!.errMessage;
      } else if (res!.results != null) {
        listItemsCategory = res.results;
      }
    } catch (e) {
      itemErrorMessage = e.toString();
    }
    notifyListeners();
  }
  
}
