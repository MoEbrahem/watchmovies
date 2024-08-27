class Movie {
  int id;
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  String releaseDate;
  double voteAverage;

  Movie(
      {
      required this.id,
      required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overView,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json["title"] as String,
        backDropPath: json["backdrop_path"] as String,
        originalTitle: json["original_title"] as String,
        overView: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        releaseDate: json["release_date"] as String,
        voteAverage: json["vote_average"] as double);
  }
}

// class Movie {
//   String? success;
//   String? status_code;
//   String? errMessage;
//   Dates? dates;
//   int? page;
//   List<Results>? results;
//   int? totalPages;
//   int? totalResults;

//   Movie({
//     this.dates,
//     this.page,
//     this.results,
//     this.totalPages,
//     this.totalResults,
//     this.errMessage,
//     this.status_code,
//     this.success,
//   });

//   Movie.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     status_code = json['status_code'];
//     errMessage = json['status_message'];

//     dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
//     page = json['page'];
//     if (json['results'] != null) {
//       results = <Results>[];
//       json['results'].forEach((v) {
//         results!.add(new Results.fromJson(v));
//       });
//     }
//     totalPages = json['total_pages'];
//     totalResults = json['total_results'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.dates != null) {
//       data['dates'] = this.dates!.toJson();
//     }
//     data['page'] = this.page;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     data['total_pages'] = this.totalPages;
//     data['total_results'] = this.totalResults;
//     return data;
//   }
// }

// class Dates {
//   String? maximum;
//   String? minimum;

//   Dates({this.maximum, this.minimum});

//   Dates.fromJson(Map<String, dynamic> json) {
//     maximum = json['maximum'];
//     minimum = json['minimum'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['maximum'] = this.maximum;
//     data['minimum'] = this.minimum;
//     return data;
//   }
// }

// class Results {
//   bool? adult;
//   String? backdropPath;
//   List<int>? genreIds;
//   int? id;
//   String? originalLanguage;
//   String? originalTitle;
//   String? overview;
//   double? popularity;
//   String? posterPath;
//   String? releaseDate;
//   String? title;
//   bool? video;
//   double? voteAverage;
//   int? voteCount;

//   Results(
//       {this.adult,
//       this.backdropPath,
//       this.genreIds,
//       this.id,
//       this.originalLanguage,
//       this.originalTitle,
//       this.overview,
//       this.popularity,
//       this.posterPath,
//       this.releaseDate,
//       this.title,
//       this.video,
//       this.voteAverage,
//       this.voteCount});

//   Results.fromJson(Map<String, dynamic> json) {
//     adult = json['adult'];
//     backdropPath = json['backdrop_path'];
//     genreIds = json['genre_ids'].cast<int>();
//     id = json['id'];
//     originalLanguage = json['original_language'];
//     originalTitle = json['original_title'];
//     overview = json['overview'];
//     popularity = json['popularity'];
//     posterPath = json['poster_path'];
//     releaseDate = json['release_date'];
//     title = json['title'];
//     video = json['video'];
//     voteAverage = json['vote_average'];
//     voteCount = json['vote_count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['adult'] = this.adult;
//     data['backdrop_path'] = this.backdropPath;
//     data['genre_ids'] = this.genreIds;
//     data['id'] = this.id;
//     data['original_language'] = this.originalLanguage;
//     data['original_title'] = this.originalTitle;
//     data['overview'] = this.overview;
//     data['popularity'] = this.popularity;
//     data['poster_path'] = this.posterPath;
//     data['release_date'] = this.releaseDate;
//     data['title'] = this.title;
//     data['video'] = this.video;
//     data['vote_average'] = this.voteAverage;
//     data['vote_count'] = this.voteCount;
//     return data;
//   }
// }
