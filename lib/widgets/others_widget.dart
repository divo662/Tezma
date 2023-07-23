import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/movie_api.dart';
import '../components/top_rated_pages.dart';
import '../models/movie_model.dart';
import '../pages/splash_screen_page.dart';

class OtherWidgets extends StatefulWidget {
  const OtherWidgets({Key? key}) : super(key: key);

  @override
  State<OtherWidgets> createState() => _OtherWidgetsState();
}

class _OtherWidgetsState extends State<OtherWidgets> {
  TextEditingController controller = TextEditingController();
  int currentPage = 1;
  String? errorMessage;
  String? _searchQuery;
  List<MovieModel> _movies = [];


  Future<List<MovieModel>> fetchOtherMovies1({int page = 1, String? query}) async {
    const apiKey = '9ee736e148e808222f04c1535dc80b64';

    // Fetch other movies if query is not provided
    if (query == null || query.isEmpty) {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc&with_genres=99';
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
              genres: [], // You can include the genres if available
              voteAverage: result['vote_average'].toDouble(),
              runtime: result['runtime'] ?? 0,
            );
          }).toList();
          return movies;
        }
      }
    }

    // Search movies if query is provided
    final encodedQuery = Uri.encodeComponent(query ?? ''); // Provide a default value if query is null
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$encodedQuery&page=1&language=en-US&region=ZA';

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
            genres: [], // You can include the genres if available
            voteAverage: result['vote_average'].toDouble(),
            runtime: result['runtime'] ?? 0,
          );
        }).toList();
        return movies;
      }
    }
    throw Exception('Failed to fetch movies');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Other Movies"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  Column(
        children: [
          Container(
            height: 46,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              onChanged: (query) async {
                setState(() {
                  _searchQuery = query; // Update the search query variable
                });
              },
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 19,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search for Movies...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                  fontSize: 17,
                ),
                prefixIcon: const Icon(CupertinoIcons.search),
                suffixIcon: _searchQuery != null && _searchQuery!.isNotEmpty
                    ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
// Set an empty list to reset the movies
                        _searchQuery = null;
                        controller.clear(); // Clear the text field
                      });
                    },
                  ),
                )
                    : null,
                contentPadding: const EdgeInsets.all(7),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: FutureBuilder<List<MovieModel>>(
              future: fetchOtherMovies1(page: currentPage, query: _searchQuery),
              builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Failed to fetch movies.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final List<MovieModel> movies = snapshot.data!;

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final List<MovieModel> movies = snapshot.data!;
                      final MovieModel ratedMovies = movies[index];
                      final String imageUrl = ratedMovies.posterPath;
                      final int movieId = ratedMovies.movieID;
                      final String title = ratedMovies.title; // Add this line to get the title
                      final String posterPath = ratedMovies.posterPath; // Declare the movieId variable

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 20),
                                        Text(
                                          'Fetching details...',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            fetchMovieDetails(movieId)
                                .then((movieDetails) {
                              fetchMovieCast(movieId).then((cast) {
                                // Close the dialog after fetching the data
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                // Perform navigation after the dialog is closed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return TopRatedPage(
                                      movieDetails: movieDetails,
                                      cast: cast,
                                      movieId: movieId,
                                      title: title,
                                      posterPath: posterPath,
                                    );
                                  }),
                                );
                              }).catchError((error) {
                                // Close the dialog on error
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            }).catchError((error) {
                              // Close the dialog on error
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: 'https://image.tmdb.org/t/p/w500$posterPath',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}