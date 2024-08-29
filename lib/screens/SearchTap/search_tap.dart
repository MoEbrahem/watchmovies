import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:movies_app/constants/color.dart';
import 'package:movies_app/data/Models/models/movie.dart';
import 'package:movies_app/data/searchTap/api_service.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';
import '../../widgets/SearchTab/SearchMovieCard.dart';

class SearchTap extends StatelessWidget {
  const SearchTap({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.06,
          ),
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width * 0.95,
                  ),
                  child: TypeAheadField<Movie>(
                    textFieldConfiguration: TextFieldConfiguration(
                      style: const TextStyle(color: AppColors.whiteColor),
                      cursorColor: AppColors.whiteColor,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.whiteColor,
                        ),
                        hintText: 'Search Movies...',
                        hintStyle: const TextStyle(color: AppColors.whiteColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                            width: width * 0.003,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                            width: width * 0.003,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                            width: width * 0.003,
                          ),
                        ),
                      ),
                    ),
                    suggestionsCallback: (query) async {
                      return await importMovieFromApi(query: query);
                    },
                    itemBuilder: (context, Movie movie) {
                      return MovieCard(movie: movie);
                    },
                    onSuggestionSelected: (Movie movie) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsScreenView(
                              movieId: movie.id, movieTitle: movie.title),
                        ),
                      );
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       backgroundColor: AppColors.primaryColor,
                      //       title: Text(
                      //         movie.title,
                      //         style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                      //       ),
                      //       content: Text(
                      //         'Would you like to add this movie to your watchlist?',
                      //         style: TextStyle(color: AppColors.whiteColor),
                      //       ),
                      //       actions: <Widget>[
                      //         TextButton(
                      //           onPressed: () {
                      //             // قم بإضافة الفيلم إلى قائمة المشاهدة هنا
                      //             Navigator.of(context).pop(); // اغلق النافذة المنبثقة
                      //             ScaffoldMessenger.of(context).showSnackBar(
                      //               SnackBar(
                      //                 content: Text("${movie.title} added to watchlist"),
                      //                 backgroundColor: Colors.green,
                      //               ),
                      //             );
                      //           },
                      //           child: Text('Add to Watchlist', style: TextStyle(color: AppColors.goldColor)),
                      //         ),
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pop(); // اغلق النافذة المنبثقة
                      //           },
                      //           child: Text('Cancel', style: TextStyle(color: AppColors.whiteColor)),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    },
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      color: AppColors.primaryColor,
                      elevation: 0,
                      constraints: BoxConstraints(
                        maxWidth: width * 0.9,
                        maxHeight: height * 0.80,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: height * 0.3,
                ),
                margin: EdgeInsets.only(bottom: height * 0.02),
                child: ImageIcon(
                  const AssetImage("assets/images/Icon_movies.png"),
                  size: height * 0.15,
                  color: AppColors.grayColor,
                ),
              ),
              Text(
                'No movies found',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.describtionColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
