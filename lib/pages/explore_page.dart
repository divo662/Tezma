import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/splash_screen_page.dart';
import 'package:shimmer/shimmer.dart';

import '../api/movie_api.dart';
import '../components/search_movies.dart';
import '../components/top_rated_pages.dart';
import '../models/movie_model.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController controller = TextEditingController();
  final _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Explore",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const SearchForMovie();
                          }));
                    },
                    child: Container(
                      height: 46,
                      width: 380,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Row(
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
                           Icon(CupertinoIcons.search,
                          color: Colors.grey.shade800,),
                        ],
                      ),
                    ),
                  ),

                ),
                const SizedBox(
                  height: 24,
                ),

                Text(
                  "search your favorite movies...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 320,
                  child:  CarouselSlider.builder(
                    itemCount: 20,
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 320,
                      initialPage: 3,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      aspectRatio: 16 / 9,
                      // enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.7

                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchPopularMovies(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<MovieModel>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  final List<MovieModel> movies = snapshot.data!;
                                  final MovieModel ratedMovies = movies[index];
                                  final String imageUrl = ratedMovies.posterPath;
                                  final int movieId = ratedMovies.movieID;
                                  final String title = ratedMovies.title; // Add this line to get the title
                                  final String posterPath = ratedMovies.posterPath;

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
                                                    style:
                                                    TextStyle(fontSize: 19),
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
                                          Navigator.of(context,
                                              rootNavigator: true)
                                              .pop();

                                          // Perform navigation after the dialog is closed
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) {
                                              return TopRatedPage(
                                                movieDetails: movieDetails,
                                                cast: cast,
                                                movieId: movieId, title: title,
                                                posterPath: posterPath,
                                              );
                                            }),
                                          );
                                        }).catchError((error) {
                                          // Close the dialog on error
                                          Navigator.of(context,
                                              rootNavigator: true)
                                              .pop();
                                        });
                                      }).catchError((error) {
                                        // Close the dialog on error
                                        Navigator.of(context, rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: NetworkImage(
                                            imageUrl.isNotEmpty
                                                ? 'https://image.tmdb.org/t/p/w500$imageUrl'
                                                : 'https://via.placeholder.com/150x200.png?text=No+Image',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return  const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                                'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style:TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 320,
                  child: CarouselSlider.builder(
                    itemCount: 20,
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: 320,
                        initialPage: 3,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        aspectRatio: 16 / 9,
                        // enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 0.7

                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return FutureBuilder(
                        future: fetchTopRatedMovies(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<MovieModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              final List<MovieModel> movies = snapshot.data!;
                              final MovieModel ratedMovies = movies[index];
                              final String imageUrl = ratedMovies.posterPath;
                              final int movieId = ratedMovies.movieID;
                              final String title = ratedMovies.title; // Add this line to get the title
                              final String posterPath = ratedMovies.posterPath;

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
                                                style:
                                                TextStyle(fontSize: 19),
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
                                      Navigator.of(context,
                                          rootNavigator: true)
                                          .pop();

                                      // Perform navigation after the dialog is closed
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return TopRatedPage(
                                            movieDetails: movieDetails,
                                            cast: cast,
                                            movieId: movieId, title: title,
                                            posterPath: posterPath,
                                          );
                                        }),
                                      );
                                    }).catchError((error) {
                                      // Close the dialog on error
                                      Navigator.of(context,
                                          rootNavigator: true)
                                          .pop();
                                    });
                                  }).catchError((error) {
                                    // Close the dialog on error
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      alignment: Alignment.center,
                                      image: NetworkImage(
                                        imageUrl.isNotEmpty
                                            ? 'https://image.tmdb.org/t/p/w500$imageUrl'
                                            : 'https://via.placeholder.com/150x200.png?text=No+Image',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return  const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error,
                                        color: Colors.white, size: 60),
                                    Text(
                                        'No internet connection.\n'
                                            'Please check your internet.',
                                        textAlign: TextAlign.center,
                                        style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ],
                                ),
                              );
                            }
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 320,
                  child: CarouselSlider.builder(
                    itemCount: 20,
                    carouselController: _controller,
                    options: CarouselOptions(
                        height: 320,
                        initialPage: 3,
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        aspectRatio: 16 / 9,
                        // enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 0.7

                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return FutureBuilder(
                        future: fetchKidsMovies(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<MovieModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              final List<MovieModel> movies = snapshot.data!;
                              final MovieModel ratedMovies = movies[index];
                              final String imageUrl = ratedMovies.posterPath;
                              final int movieId = ratedMovies.movieID;
                              final String title = ratedMovies.title; // Add this line to get the title
                              final String posterPath = ratedMovies.posterPath;

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
                                                style:
                                                TextStyle(fontSize: 19),
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
                                      Navigator.of(context,
                                          rootNavigator: true)
                                          .pop();

                                      // Perform navigation after the dialog is closed
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return TopRatedPage(
                                            movieDetails: movieDetails,
                                            cast: cast,
                                            movieId: movieId, title: title,
                                            posterPath: posterPath,
                                          );
                                        }),
                                      );
                                    }).catchError((error) {
                                      // Close the dialog on error
                                      Navigator.of(context,
                                          rootNavigator: true)
                                          .pop();
                                    });
                                  }).catchError((error) {
                                    // Close the dialog on error
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      alignment: Alignment.center,
                                      image: NetworkImage(
                                        imageUrl.isNotEmpty
                                            ? 'https://image.tmdb.org/t/p/w500$imageUrl'
                                            : 'https://via.placeholder.com/150x200.png?text=No+Image',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return  const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error,
                                        color: Colors.white, size: 60),
                                    Text(
                                        'No internet connection.\n'
                                            'Please check your internet.',
                                        textAlign: TextAlign.center,
                                        style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ],
                                ),
                              );
                            }
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
