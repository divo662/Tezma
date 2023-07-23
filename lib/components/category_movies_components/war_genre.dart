import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../api/category_movies_api.dart';
import '../../api/movie_api.dart';
import '../../models/movie_model.dart';
import '../../pages/splash_screen_page.dart';
import '../top_rated_pages.dart';

class WarGenre extends StatefulWidget {
  const WarGenre({Key? key}) : super(key: key);

  @override
  State<WarGenre> createState() => _WarGenreState();
}

class _WarGenreState extends State<WarGenre> {
  TextEditingController controller = TextEditingController();
  int currentPage = 1;
  List<MovieModel> _movies = []; // Declare the _movies list
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    // Fetch the first page of action movies and update the _movies list
    fetchWarGenre(page: 1).then((movies) {
      setState(() {
        _movies = movies;
      });
    }).catchError((error) {
      print('Failed to fetch action movies: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('War'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<MovieModel>>(
              future: fetchWarGenre(page: currentPage, query: _searchQuery),
              builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final List<MovieModel> movies = snapshot.data!;

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 0.7,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final List<MovieModel> movies = snapshot.data!;
                      final MovieModel ratedMovies = movies[index];
                      final String imageUrl = ratedMovies.posterPath;
                      final int movieId = ratedMovies.movieID;
                      final String title = ratedMovies.title; // Add this line to get the title
                      final String posterPath = ratedMovies.posterPath;

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
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            fetchMovieDetails(movieId).then((movieDetails) {
                              fetchMovieCast(movieId).then((cast) {
                                // Close the dialog after fetching the data
                                Navigator.of(context, rootNavigator: true).pop();

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
                                Navigator.of(context, rootNavigator: true).pop();
                              });
                            }).catchError((error) {
                              // Close the dialog on error
                              Navigator.of(context, rootNavigator: true).pop();
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
                                style:  TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width * 0.037,
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
                  child: Text('No data found'),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: currentPage > 1, // Only show the button if not on the first page
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      currentPage--;
                    });
                  },
                  child: const Text(
                    "Previous",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              TextButton(onPressed: () {
                setState(() {
                  currentPage++;
                });
              }, child: const Text("Next",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),))
            ],
          ),
        ],
      ),
    );
  }
}
