import 'package:flutter/material.dart';
import 'package:movies_app/screens/WatchListTap/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        movie.imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.13,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Icon(Icons.error));
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        movie.year,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        movie.actors,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.005,
                left: MediaQuery.of(context).size.width * 0.05,
                child: Icon(
                  Icons.bookmark,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.white,
            indent: MediaQuery.of(context).size.width * 0.01,
            endIndent: MediaQuery.of(context).size.width * 0.01,
          ),
        ],
      ),
    );
  }
}
