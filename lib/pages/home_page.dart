import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/display_show_details_widget.dart';
import 'package:movie_app/components/top_rated_pages.dart';
import 'package:movie_app/pages/splash_screen_page.dart';
import 'package:movie_app/widgets/chipAction.dart';
import 'package:movie_app/widgets/popular_tv_show.dart';
import 'package:movie_app/widgets/topmovie_gridview.dart';
import 'package:movie_app/widgets/upcoming_gridview.dart';
import 'package:shimmer/shimmer.dart';

import '../api/movie_api.dart';
import '../components/category_movies_components/adventure_genre.dart';
import '../components/category_movies_components/action_movies.dart';
import '../components/category_movies_components/comedy_genre.dart';
import '../components/category_movies_components/crime_genre.dart';
import '../components/category_movies_components/documentary_genre.dart';
import '../components/category_movies_components/drama_genre.dart';
import '../components/category_movies_components/fanatasy_genre.dart';
import '../components/category_movies_components/horror_genre.dart';
import '../components/category_movies_components/mystery_genre.dart';
import '../components/category_movies_components/romance_movies.dart';
import '../components/category_movies_components/sci_fci_genre.dart';
import '../components/category_movies_components/thriller_genre.dart';
import '../components/category_movies_components/war_genre.dart';
import '../models/movie_model.dart';
import '../widgets/african_movies_widget.dart';
import '../widgets/kids_movies_widget.dart';
import '../widgets/kids_show_widget.dart';
import '../widgets/notification_modal_sheet/notification_settings.dart';
import '../widgets/others_widget.dart';
import '../widgets/popularmoviesgridview.dart';
import '../widgets/top_rated_tv_shows.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = CarouselController();
  ScrollController scrollController = ScrollController();
  bool showBackPage = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    showBackPage = false; // Set initial state

    scrollController.addListener(() {
      if (scrollController.offset >= 400 && !showBackPage) {
        setState(() {
          showBackPage = true;
        });
      } else if (scrollController.offset < 400 && showBackPage) {
        setState(() {
          showBackPage = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: showBackPage ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: FloatingActionButton(
          onPressed: () {
            scrollToTop(); // Use scrollToTop method to animate scroll
          },
          backgroundColor: Colors.indigo,
          child: const Icon(CupertinoIcons.arrow_up),
        ),
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Tezma",
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 3),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 2000));
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Category",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChipAction(
                        text: "Action",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ActionMoviesCategory();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Romance",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RomanticMovies();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Comedy",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ComedyGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Drama",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const DramaGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Crime",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CrimeGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Adventure",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AdventureGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Horror",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HorrorGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Documentary",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const DocumentaryGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "fantasy",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const FantasyGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Science Fiction",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SciFiGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Thriller",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ThrillerGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "War",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const WarGenre();
                          }));
                        },
                      ),
                      ChipAction(
                        text: "Mystery",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const MysteryGenre();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Rated Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const TopRatedMoviesScreen();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(children: [
                    CarouselSlider.builder(
                      itemCount: 20,
                      carouselController: controller,
                      options: CarouselOptions(
                        height: 360,
                        initialPage: 0,
                        autoPlay: false,
                        aspectRatio: 20 / 10,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return FutureBuilder(
                          future: fetchTopRatedMovies(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              final List<MovieModel> movies = snapshot.data!;
                              final MovieModel ratedMovies = movies[index];
                              final String imageUrl = ratedMovies.posterPath;
                              final int movieId = ratedMovies.movieID;
                              final String title = ratedMovies
                                  .title; // Add this line to get the title
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
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
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
                                child: Container(
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
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error,
                                        color: Colors.white, size: 60),
                                    Text(
                                        'No internet connection.\n'
                                        'Please check your internet.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: Shimmer(
                                period: const Duration(seconds: 2),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey[200]!,
                                    Colors.grey[400]!,
                                    Colors.grey[200]!
                                  ],
                                  stops: const [0.4, 0.5, 0.6],
                                  begin: const Alignment(-1, -0.5),
                                  end: const Alignment(1, 0.5),
                                ),
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const PopularMoviesGridView();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
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
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return TopRatedPage(
                                                movieDetails: movieDetails,
                                                cast: cast,
                                                movieId: movieId,
                                                posterPath: posterPath,
                                                title: title,
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
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
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upcoming Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const UpComingWidget();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchUpcomingMovies(),
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
                                            MaterialPageRoute(
                                                builder: (context) {
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
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
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular Tv Shows",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const PopularTvShowWidget();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchPopularTvShows(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<TvShowModel>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  final List<TvShowModel> tvShows =
                                      snapshot.data!;
                                  final TvShowModel tvShow = tvShows[index];
                                  final String imageUrl = tvShow.posterPath;
                                  final int movieId = tvShow.tvShowID;

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
                                      fetchShowDetails(movieId)
                                          .then((showDetails) {
                                        fetchShowCast(movieId).then((cast) {
                                          // Close the dialog after fetching the data
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          // Perform navigation after the dialog is closed
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return ShowDetailsWidget(
                                                movieId: movieId,
                                                showDetails: showDetails,
                                                showCast:
                                                    cast, // Assign cast to showCast
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: imageUrl.isNotEmpty
                                              ? NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500$imageUrl')
                                              : const NetworkImage(
                                                  'https://via.placeholder.com/150x200.png?text=No+Image'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Rated Tv Shows",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const TopRatedTvShowWidget();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchTopRatedTvShows(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<TvShowModel>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  final List<TvShowModel> tvShows =
                                      snapshot.data!;
                                  final TvShowModel tvShow = tvShows[index];
                                  final String imageUrl = tvShow.posterPath;
                                  final int movieId = tvShow.tvShowID;

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
                                      fetchShowDetails(movieId)
                                          .then((showDetails) {
                                        fetchShowCast(movieId).then((cast) {
                                          // Close the dialog after fetching the data
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          // Perform navigation after the dialog is closed
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return ShowDetailsWidget(
                                                movieId: movieId,
                                                showDetails: showDetails,
                                                showCast:
                                                    cast, // Assign cast to showCast
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: imageUrl.isNotEmpty
                                              ? NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500$imageUrl')
                                              : const NetworkImage(
                                                  'https://via.placeholder.com/150x200.png?text=No+Image'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Kids Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const KidsMoviesWidget();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
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
                                            MaterialPageRoute(
                                                builder: (context) {
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
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
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Kids Show",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const KidsShowWidget();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchKidsShows(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<TvShowModel>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  final List<TvShowModel> tvShows =
                                      snapshot.data!;
                                  final TvShowModel tvShow = tvShows[index];
                                  final String imageUrl = tvShow.posterPath;
                                  final int movieId = tvShow.tvShowID;

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
                                      fetchShowDetails(movieId)
                                          .then((showDetails) {
                                        fetchShowCast(movieId).then((cast) {
                                          // Close the dialog after fetching the data
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();

                                          // Perform navigation after the dialog is closed
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return ShowDetailsWidget(
                                                movieId: movieId,
                                                showDetails: showDetails,
                                                showCast:
                                                    cast, // Assign cast to showCast
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          image: imageUrl.isNotEmpty
                                              ? NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500$imageUrl')
                                              : const NetworkImage(
                                                  'https://via.placeholder.com/150x200.png?text=No+Image'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "African Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AfricanMoviesWidget();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchAfricanMovies(),
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
                                            MaterialPageRoute(
                                                builder: (context) {
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
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
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Documentary movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const OtherWidgets();
                          }));
                        },
                        child: const Text("See all"))
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 20,
                        carouselController: controller,
                        options: CarouselOptions(
                          height: 360,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 15 / 5,
                          autoPlayInterval: const Duration(seconds: 2),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return FutureBuilder(
                            future: fetchOtherMovies(),
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
                                            MaterialPageRoute(
                                                builder: (context) {
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
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    },
                                    child: Container(
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
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.white, size: 60),
                                        Text(
                                            'No internet connection.\n'
                                            'Please check your internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
