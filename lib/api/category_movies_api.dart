import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';
const apiKey = '9ee736e148e808222f04c1535dc80b64';
int currentPage = 1;

Future<List<MovieModel>> fetchActionMovies({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final encodedQuery = Uri.encodeComponent(query ?? ''); // Provide a default value if query is null
    final url =
        'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=28&query=$encodedQuery';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null) {
        final List<dynamic> results = data['results'];
        final List<MovieModel> movies = results.map((result) {
          final genreIds = List<int>.from(result['genre_ids'] ?? []);
          final genres = genreIds.map((genreId) => genresMap[genreId]).toList();
          return MovieModel(
            movieID: result['id'],
            title: result['title'],
            posterPath: result['poster_path'] ?? "",
            overview: result['overview'] ?? "",
            revenue: result['revenue'] ?? 0,
            releaseDate: result['release_date'] ?? "",
            tagline: result['tagline'] ?? "",
            status: result['status'] ?? "",
            genres: [],
            voteAverage: result['vote_average'].toDouble(),
            runtime: result['runtime'] ?? 0,
          );
        }).toList();
        return movies;
      }
    }
  }
  throw Exception('Failed to fetch action movies');
}

Future<List<MovieModel>> fetchRomanticMovies({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final romanceGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Romance',
      orElse: () => null,
    )['id'];

    if (romanceGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$romanceGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            final genreIds = List<int>.from(result['genre_ids'] ?? []);
            final genres = genreIds.map((genreId) => genresMap[genreId]).toList();
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [],
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Romance genre not found');
    }
  }
  throw Exception('Failed to fetch romantic movies');
}

Future<List<MovieModel>> fetchComedyMovies({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final comedyGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Comedy',
      orElse: () => null,
    )['id'];

    if (comedyGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$comedyGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            final genreIds = List<int>.from(result['genre_ids'] ?? []);
            final genres = genreIds.map((genreId) => genresMap[genreId]).toList();
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [],
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Comedy genre not found');
    }
  }
  throw Exception('Failed to fetch comedy movies');
}

Future<List<MovieModel>> fetchDramaGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final dramaGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Drama',
      orElse: () => null,
    )['id'];

    if (dramaGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$dramaGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Drama genre not found');
    }
  }
  throw Exception('Failed to fetch drama movies');
}

Future<List<MovieModel>> fetchCrimeGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final crimeGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Crime',
      orElse: () => null,
    )['id'];

    if (crimeGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$crimeGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Crime genre not found');
    }
  }
  throw Exception('Failed to fetch crime movies');
}

Future<List<MovieModel>> fetchAdventureGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final adventureGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Adventure',
      orElse: () => null,
    )['id'];

    if (adventureGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$adventureGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Adventure genre not found');
    }
  }
  throw Exception('Failed to fetch adventure movies');
}

Future<List<MovieModel>> fetchHorrorGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
  'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';

  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final horrorGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Horror',
      orElse: () => null,
    )['id'];

    if (horrorGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$horrorGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            final genreIds = List<int>.from(result['genre_ids'] ?? []);
            final genres = genreIds.map((genreId) => genresMap[genreId]).toList();
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [],
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Horror genre not found');
    }
  }
  throw Exception('Failed to fetch horror movies');
}

Future<List<MovieModel>> fetchDocumentaryGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final documentaryGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Documentary',
      orElse: () => null,
    )['id'];

    if (documentaryGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$documentaryGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Documentary genre not found');
    }
  }
  throw Exception('Failed to fetch documentary movies');
}

Future<List<MovieModel>> fetchFantasyGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final fantasyGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Fantasy',
      orElse: () => null,
    )['id'];

    if (fantasyGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$fantasyGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Fantasy genre not found');
    }
  }
  throw Exception('Failed to fetch fantasy movies');
}

Future<List<MovieModel>> fetchScienceFictionGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final scienceFictionGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Science Fiction',
      orElse: () => null,
    )['id'];

    if (scienceFictionGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$scienceFictionGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Science Fiction genre not found');
    }
  }
  throw Exception('Failed to fetch science fiction movies');
}

Future<List<MovieModel>> fetchThrillerGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final thrillerGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Thriller',
      orElse: () => null,
    )['id'];

    if (thrillerGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$thrillerGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Thriller genre not found');
    }
  }
  throw Exception('Failed to fetch thriller movies');
}

Future<List<MovieModel>> fetchWarGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final warGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'War',
      orElse: () => null,
    )['id'];

    if (warGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$warGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('War genre not found');
    }
  }
  throw Exception('Failed to fetch war movies');
}

Future<List<MovieModel>> fetchMysteryGenre({int page = 1, String? query}) async {
  const apiKey = '9ee736e148e808222f04c1535dc80b64';

  const String genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
  final genreResponse = await http.get(Uri.parse(genreUrl));
  if (genreResponse.statusCode == 200) {
    final genreData = json.decode(genreResponse.body);
    final List<dynamic> genresList = genreData['genres'];
    final Map<int, String> genresMap = genresList.fold({}, (map, genre) {
      map[genre['id']] = genre['name'];
      return map;
    });

    final mysteryGenreId = genresList.firstWhere(
          (genre) => genre['name'] == 'Mystery',
      orElse: () => null,
    )['id'];

    if (mysteryGenreId != null) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page&language=en-US&with_genres=$mysteryGenreId&query=$query';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final List<dynamic> results = data['results'];
          final List<MovieModel> movies = results.map((result) {
            return MovieModel(
              movieID: result['id'],
              title: result['title'],
              posterPath: result['poster_path'] ?? "",
              overview: result['overview'] ?? "",
              revenue: result['revenue'] ?? 0,
              releaseDate: result['release_date'] ?? "",
              tagline: result['tagline'] ?? "",
              status: result['status'] ?? "",
              genres: [], // Empty list for genres
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    } else {
      throw Exception('Mystery genre not found');
    }
  }
  throw Exception('Failed to fetch mystery movies');
}
