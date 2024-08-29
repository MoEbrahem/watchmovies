import 'package:flutter/material.dart';
import 'package:movies_app/data/ApiManager.dart';
import 'package:movies_app/data/Models/detailsScreen/MovieDetails.dart';

class DetailsScreenViewModel extends ChangeNotifier {
  movieDetailsModel? movieDetails;
  String? errMessage;

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
}
