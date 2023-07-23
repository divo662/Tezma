class MovieModel {
  final int movieID;
  final String title;
  final String posterPath;
  final String overview;
  final int revenue;
  final String releaseDate;
  final String tagline;
  final String status;
  final List<GenreModel>? genres;
  final double voteAverage;
  final int? runtime;

  MovieModel({
    required this.movieID,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.revenue,
    required this.releaseDate,
    required this.tagline,
    required this.status,
    this.genres,
    required this.voteAverage,
    this.runtime,
  }) : assert(runtime != null);

  List<GenreModel>? getGenreModels() {
    return genres?.map((genre) => GenreModel(name: genre.name)).toList();
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Parse the genre list
    final List<dynamic>? genreList = json['genres'];
    List<GenreModel>? genres;
    if (genreList != null) {
      genres = genreList.map((genre) => GenreModel(name: genre['name'])).toList();
    }

    return MovieModel(
      title: json['title'],
      overview: json['overview'] ?? "",
      posterPath: json['poster_path'] ?? "",
      movieID: json["id"],
      revenue: json["revenue"] ?? 0,
      releaseDate: json["release_date"] ?? '',
      tagline: json["tagline"] ?? '',
      status: json["status"] ?? '',
      genres: genres,
      voteAverage: json["vote_average"].toDouble(),
      runtime: json["runtime"] ?? 0,
    );
  }
}

class CastModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'] ?? '', // Add the null check here
    );
  }

}

class GenreModel {
  final String name;

  GenreModel({
    required this.name,
  });
}

class TvShowModel {
  final int tvShowID; // Renamed from movieID
  final String name; // Renamed from title
  final String posterPath;
  final String overview;
  final String tagline;
  final String status;
  final String releaseDate;
  final List<GenreModel>? genres;
  final double voteAverage;
  final DateTime? firstAirDate; // Added this field

  TvShowModel({
    required this.tvShowID,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.tagline,
    required this.status,
    required this.genres,
    required this.voteAverage,
    required this.firstAirDate,
    required this.releaseDate,
  });

  List<GenreModel>? getGenreModels() {
    return genres?.map((genre) => GenreModel(name: genre.name)).toList();
  }

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? genreList = json['genres'];
    List<GenreModel>? genres;
    if (genreList != null) {
      genres = genreList.map((genre) => GenreModel(name: genre['name'])).toList();
    }

    return TvShowModel(
      tvShowID: json["id"],
      name: json['name'],
      posterPath: json['poster_path'] ?? "",
      overview: json['overview'] ?? "",
      tagline: json["tagline"] ?? "",
      status: json["status"] ?? "",
      genres: genres,
      voteAverage: (json["vote_average"] as num).toDouble(),
      firstAirDate: json["first_air_date"] != null ? DateTime.parse(json["first_air_date"]) : null,
      releaseDate: json["release_date"] ?? '',
    );
  }
}


