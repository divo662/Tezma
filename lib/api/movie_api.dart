import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';
const apiKey = '9ee736e148e808222f04c1535dc80b64';
int currentPage = 1;


Future<List<CastModel>> fetchMovieCast(int movieId) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<CastModel> cast = (data['cast'] as List<dynamic>)
        .map((json) => CastModel.fromJson(json))
        .toList();
    return cast;
  }

  throw Exception('Failed to fetch movie cast');
}

Future<MovieModel> fetchMovieDetails(int movieId) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=en-US';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final movieDetails = MovieModel. fromJson(data);
    return movieDetails;
  }

  throw Exception('Failed to fetch movie details');
}

Future<List<CastModel>> fetchShowCast(int movieId) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  final url = 'https://api.themoviedb.org/3/tv/$movieId/credits?api_key=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<CastModel> showCast = (data['cast'] as List<dynamic>)
        .map((json) => CastModel.fromJson(json))
        .toList();
    return showCast;
  }

  throw Exception('Failed to fetch show cast');
}

Future<TvShowModel> fetchShowDetails(int movieId) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  final url = 'https://api.themoviedb.org/3/tv/$movieId?api_key=$apiKey&language=en-US';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final showDetails = TvShowModel.fromJson(data);
    return showDetails;
  }

  throw Exception('Failed to fetch show details');
}


Future<List<MovieModel>> fetchTopRatedMovies({ String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&page=1&language=en-US';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<MovieModel> movies = results.map((result) => MovieModel(
        movieID: result['id'],
        title: result['title'],
        posterPath: result['poster_path'] ?? "",
        overview: result['overview'] ?? "",
        revenue: result['revenue'] ?? 0,
        releaseDate: result['release_date'] ?? "",
        tagline: result['tagline'] ?? "",
        status: result['status']?? "",
        genres: [], // Update with the actual genre data
        voteAverage: result['vote_average'],
        runtime: result["runtime"] ?? 0, // Provide a default value of 0 when runtime is null
      )).toList();
      return movies; // Return the list of movies
    }
  }
  throw Exception('Failed to fetch top rated movies');
}



Future<List<MovieModel>> fetchPopularMovies({String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=1&language=en-US";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<MovieModel> movies = results.map((result) => MovieModel(
        movieID: result['id'],
        title: result['title'],
        posterPath: result['poster_path'] ?? "",
        overview: result['overview'] ?? "",
        revenue: result['revenue'] ?? 0,
        releaseDate: result['release_date'] ?? "",
        tagline: result['tagline'] ?? "",
        status: result['status'] ?? "",
        genres: [], // Update with the actual genre data
        voteAverage: (result['vote_average'] as num).toDouble(), // Fix the type conversion here
        runtime: result["runtime"] ?? 0, // Provide a default value of 0 when runtime is null
      )).toList();
      return movies; // Return the list of movies
    }
  }
  throw Exception('Failed to fetch popular movies');
}


Future<List<MovieModel>> fetchUpcomingMovies() async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&page=1&language=en-US";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<MovieModel> movies = results.map((result) => MovieModel(
        movieID: result['id'],
        title: result['title'],
        posterPath: result['poster_path'] ?? "",
        overview: result['overview'] ?? "",
        revenue: result['revenue'] ?? 0,
        releaseDate: result['release_date'] ?? "",
        tagline: result['tagline'] ?? "",
        status: result['status'] ?? "",
        genres: [], // Update with the actual genre data
        voteAverage: (result['vote_average'] as num).toDouble(), // Fix the type conversion here
        runtime: result["runtime"] ?? 0, // Provide a default value of 0 when runtime is null
      )).toList();
      return movies; // Return the list of movies
    }
  }
  throw Exception('Failed to fetch upcoming movies');
}

Future<List<TvShowModel>> fetchPopularTvShows() async {
const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url = "https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&page=1&language=en-US";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<TvShowModel> tvShows = results.map((result) {
        final List<dynamic>? genreList = result['genres'];
        List<GenreModel>? genres;
        if (genreList != null) {
          genres = genreList.map((genre) => GenreModel(name: genre['name'])).toList();
        }

        return TvShowModel(
          tvShowID: result['id'],
          name: result['name'],
          posterPath: result['poster_path'] ?? "",
          overview: result['overview'] ?? "",
          releaseDate: result['release_date'] ?? "",
          tagline: result['tagline'] ?? "",
          status: result['status'] ?? "",
          genres: genres,
          voteAverage: result['vote_average'] != null ? (result['vote_average'] as num).toDouble() : 0.0,
          firstAirDate: result["first_air_date"] != null ? DateTime.parse(result["first_air_date"]) : null,
        );

      }).toList();
      return tvShows;
    }
  }
  throw Exception('Failed to fetch popular shows');
}


Future<List<TvShowModel>> fetchTopRatedTvShows() async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&page=1&language=en-US";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<TvShowModel> tvShows = results.map((result) {
        final List<dynamic>? genreList = result['genres'];
        List<GenreModel>? genres;
        if (genreList != null) {
          genres = genreList.map((genre) => GenreModel(name: genre['name'])).toList();
        }

        return TvShowModel(
          tvShowID: result['id'],
          name: result['name'],
          posterPath: result['poster_path'] ?? "",
          overview: result['overview'] ?? "",
          releaseDate: result['release_date'] ?? "",
          tagline: result['tagline'] ?? "",
          status: result['status'] ?? "",
          genres: genres,
          voteAverage: result['vote_average'] != null ? (result['vote_average'] as num).toDouble() : 0.0,
          firstAirDate: result["first_air_date"] != null ? DateTime.parse(result["first_air_date"]) : null,
        );

      }).toList();
      return tvShows;
    }
  }
  throw Exception('Failed to fetch top rated shows');
}

Future<List<MovieModel>> fetchOtherMovies() async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc&with_genres=99";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<MovieModel> movies = results.map((result) => MovieModel(
        movieID: result['id'],
        title: result['title'],
        posterPath: result['poster_path'] ?? "",
        overview: result['overview'] ?? "",
        revenue: result['revenue'] ?? 0,
        releaseDate: result['release_date'] ?? "",
        tagline: result['tagline'] ?? "",
        status: result['status'] ?? "",
        genres: [], // Update with the actual genre data
        voteAverage: (result['vote_average'] as num).toDouble(), // Fix the type conversion here
        runtime: result["runtime"] ?? 0, // Provide a default value of 0 when runtime is null
      )).toList();
      return movies; // Return the list of movies
    }
  }
  throw Exception('Failed to fetch popular movies');
}

Future<List<TvShowModel>> fetchKidsShows() async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&sort_by=popularity.desc&with_genres=10762";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<TvShowModel> tvShows = results.map((result) {
        final List<dynamic>? genreList = result['genres'];
        List<GenreModel>? genres;
        if (genreList != null) {
          genres = genreList.map((genre) => GenreModel(name: genre['name'])).toList();
        }

        return TvShowModel(
          tvShowID: result['id'],
          name: result['name'],
          posterPath: result['poster_path'] ?? "",
          overview: result['overview'] ?? "",
          releaseDate: result['release_date'] ?? "",
          tagline: result['tagline'] ?? "",
          status: result['status'] ?? "",
          genres: genres,
          voteAverage: result['vote_average'] != null ? (result['vote_average'] as num).toDouble() : 0.0,
          firstAirDate: result["first_air_date"] != null ? DateTime.parse(result["first_air_date"]) : null,
        );

      }).toList();
      return tvShows;
    }
  }
  throw Exception('Failed to fetch popular movies');
}

Future<List<MovieModel>> fetchKidsMovies() async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity."
      "desc&certification_country=US&certification.lte=G&with_genres=16";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<MovieModel> movies = results.map((result) => MovieModel(
        movieID: result['id'],
        title: result['title'],
        posterPath: result['poster_path'] ?? "",
        overview: result['overview'] ?? "",
        revenue: result['revenue'] ?? 0,
        releaseDate: result['release_date'] ?? "",
        tagline: result['tagline'] ?? "",
        status: result['status'] ?? "",
        genres: [], // Update with the actual genre data
        voteAverage: (result['vote_average'] as num).toDouble(), // Fix the type conversion here
        runtime: result["runtime"] ?? 0, // Provide a default value of 0 when runtime is null
      )).toList();
      return movies; // Return the list of movies
    }
  }
  throw Exception('Failed to fetch popular movies');
}

Future<List<MovieModel>> fetchAfricanMovies() async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';
  const url =
      "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity."
      "desc&with_original_language=sw";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null) {
      final List<dynamic> results = data['results'];
      final List<MovieModel> movies = results.map((result) => MovieModel(
        movieID: result['id'],
        title: result['title'],
        posterPath: result['poster_path'] ?? "",
        overview: result['overview'] ?? "",
        revenue: result['revenue'] ?? 0,
        releaseDate: result['release_date'] ?? "",
        tagline: result['tagline'] ?? "",
        status: result['status'] ?? "",
        genres: [], // Update with the actual genre data
        voteAverage: (result['vote_average'] as num).toDouble(), // Fix the type conversion here
        runtime: result["runtime"] ?? 0, // Provide a default value of 0 when runtime is null
      )).toList();
      return movies; // Return the list of movies
    }
  }
  throw Exception('Failed to fetch popular movies');
}

String formatRevenue(int revenue) {
  if (revenue == null) {
    return 'Unknown'; // Handle cases where revenue is not available
  }

  final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return formatter.format(revenue);
}


void checkImageURL(String imageUrl) async {
  final response = await http.head(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    print('Image URL is valid.');
  } else {
    print('Image URL returned an error. Status Code: ${response.statusCode}');
    print('Error Message: ${response.body}');
  }
}

