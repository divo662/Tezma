import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Movie {
  final String id;
  final String title;
  final String posterPath;
  final int movieID; // Add the movieID field

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.movieID, // Initialize the movieID field
  });
}



class MovieProvider with ChangeNotifier {
  final List<Movie> _favoriteMovies = [];

  List<Movie> get favoriteMovies => _favoriteMovies;

  void addMovieToFavorites(Movie movie) {
    _favoriteMovies.add(movie);
    notifyListeners();
  }

  void removeMovieFromFavorites(Movie movie) {
    _favoriteMovies.remove(movie);
    notifyListeners();
  }
}

