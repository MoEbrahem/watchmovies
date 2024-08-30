import 'package:flutter/material.dart';
import 'package:movies_app/data/ApiManager.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';

import '../data/Models/detailsScreen/LikeMoviesModel.dart';

class DetailsScreenViewModel extends ChangeNotifier {
  movieDetailsModel? movieDetails;
  moreLikeMovies? likeMovies;
  String? errMessage;
  String? errlikeMovies;

  getMovieDetails(int movieId) async {
    movieDetails = null;
    errMessage = null;
    notifyListeners();
    try {
      var res = await ApiManager.getmoviesDetails(movieId);
      if (res?.status_message != null && res?.success == false) {
        errMessage = res!.status_message;
      } else {
        movieDetails = res;
      }
    } catch (e) {
      errMessage = e.toString();
    }
    notifyListeners();
  }

  getMoreLikeMovies(int movieId) async {
    likeMovies = null;
    errlikeMovies = null;
    notifyListeners();
    try {
      var res = await ApiManager.getMoreLikeMovies(movieId);
      if (res?.status_message != null && res?.success == false) {
        errlikeMovies = res!.status_message;
      } else {
        likeMovies = res;
      }
    } catch (e) {
      errMessage = e.toString();
    }
    notifyListeners();
  }
}
