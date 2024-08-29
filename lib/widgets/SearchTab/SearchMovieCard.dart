import 'package:flutter/material.dart';
import 'package:movies_app/screens/SearchTap/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: height*0.02),
      width: width * 0.878,
      height: height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.imageUrl}',
                  fit: BoxFit.fill,
                  width: width * 0.28,
                  height: height * 0.19,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width*0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      movie.year,
                      style:
                          Theme.of(context).textTheme.bodySmall
                    ),
                    Text(
                      movie.actors,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
