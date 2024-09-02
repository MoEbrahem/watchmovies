import 'package:flutter/material.dart';
import 'package:movies_app/widgets/details_Screen/details_Screen_View.dart';
import '../../data/Models/home_tap_api.dart';

class WatchMovieCard extends StatelessWidget {
  final Movie movie;
  String? posterpath;

  WatchMovieCard({required this.movie,required this.posterpath});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreenView(
              movieId: movie.id,
              movieTitle: movie.title,
              isSelected: true,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: height * 0.02),
        width: width * 0.878,
        height: height * 0.15,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: posterpath == null || posterpath == ''
                  ? Image.network(
                      'https://kennyleeholmes.com/wp-content/uploads/2017/09/no-image-available.png',
                      fit: BoxFit.fill,
                      width: width * 0.3,
                      height: double.infinity,
                      // width * 0.32,
                    )
                  : Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: width * 0.3,
                    ),
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    movie.releaseDate,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    movie.overView.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
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
