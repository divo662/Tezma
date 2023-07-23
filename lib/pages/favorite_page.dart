import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/splash_screen_page.dart';
import 'package:provider/provider.dart';

import '../api/movie_api.dart';
import '../components/search_movies.dart';
import '../components/top_rated_pages.dart';
import '../provider/api_provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // ... Your existing code ...

  @override
  Widget build(BuildContext context) {

    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const SearchForMovie();
                    }),
                  );
                },
                child: Container(
                  height: 46,
                  width: 380,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "search...",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.search,
                        color: Colors.grey.shade800,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "These are your favorite movies...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: movieProvider.favoriteMovies.isEmpty
                    ? Center(
                  child: Text(
                    "No movies added to favorites.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: movieProvider.favoriteMovies.length,
                  itemBuilder: (context, index) {
                    final movie = movieProvider.favoriteMovies[index];

                    return GestureDetector(
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

                        fetchMovieDetails(movie.movieID)
                            .then((movieDetails) {
                          fetchMovieCast(movie.movieID).then((cast) {
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
                                  movieId: movie.movieID,
                                  title: movie.title,
                                  posterPath: movie.posterPath,
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
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade700,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.movie,
                            size: 50,
                            color: Colors.grey,
                          ),
                          title: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                movieProvider.removeMovieFromFavorites(
                                    movie);
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


