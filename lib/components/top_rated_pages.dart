import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/pages/splash_screen_page.dart';
import 'package:provider/provider.dart';
import '../api/movie_api.dart';
import '../models/movie_model.dart';
import '../provider/api_provider.dart';

class TopRatedPage extends StatefulWidget {
  final int movieId;
  final MovieModel movieDetails;
  final List<dynamic> cast;
  final dynamic showDetails;
  final dynamic showCast;
  final String title;
  final String posterPath;

  const TopRatedPage({
    Key? key,
    required this.movieId,
    required this.movieDetails,
    required this.cast,
    this.showDetails,
    this.showCast, required this.title, required this.posterPath,
  }) : super(key: key);

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  late Future<MovieModel> movieDetails;
  late Future<dynamic> showDetails;
  late Future<List<dynamic>> movieCast;
  late Future<List<dynamic>> showCast;

  @override
  void initState() {
    super.initState();
    movieDetails = fetchMovieDetails(widget.movieId);
    movieCast = fetchMovieCast(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final int movieId = widget.movieId;
    final String title = widget.title; // Access the 'title' from the widget
    final String posterPath = widget.posterPath;
    // Access the 'posterPath' from the widget

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 45,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                final movieProvider = Provider.of<MovieProvider>(context, listen: false);
                movieProvider.addMovieToFavorites(
                  Movie(
                    id: movieId.toString(),
                    title: title,
                    posterPath: "",
                    movieID: movieId,
                  ),
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Added to Favorites"),
                      content: const Text("The movie has been added to your favorites."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  // Update the state to trigger the icon change
                });
              },

              child: Container(
                height: 40,
                width: 43,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bookmark_outline_rounded,
                  color: Colors.blue.shade900,
                ),
              ),
            ),


          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<MovieModel>(
              future: fetchMovieDetails(movieId),
              builder: (BuildContext context, AsyncSnapshot<MovieModel> snapshot) {
                if (snapshot.hasData) {
                  final movieDetails = snapshot.data!;
                  int durationInMinutes = movieDetails.runtime ?? 0;
                  int hours = durationInMinutes ~/ 60; // Get the whole number of hours
                  int minutes = durationInMinutes % 60; // Get the remaining minutes
                  List<GenreModel> genres = movieDetails.getGenreModels() ?? [];

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 470,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              alignment: Alignment.center,
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        movieDetails.title,
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        // Add ellipsis for long names
                                        maxLines: 3, // Set maximum number of lines to 1
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_sharp,
                                          color: Colors.blue.shade900,
                                        ),
                                        Text(
                                          '${movieDetails.voteAverage}',
                                          style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Genres: ${genres.map((genre) => genre.name).join(', ')}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Status: ${movieDetails.status ?? ""} ",
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  movieDetails.tagline ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Description:",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Display the movie description
                                Text(
                                  movieDetails.overview,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          color: Colors.blue.shade900,
                                        ),
                                        Text(
                                          DateFormat('MMMM d, y')
                                              .format(DateTime.parse(movieDetails.releaseDate)),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: Colors.blue.shade900,
                                        ),
                                        Text(
                                          '$hours h $minutes min',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Generated Revenue: ${formatRevenue(movieDetails.revenue)}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Display movie cast
                        FutureBuilder<List<CastModel>>(
                          future: fetchMovieCast(movieId),
                          builder: (BuildContext context, AsyncSnapshot<List<CastModel>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                final cast = snapshot.data!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Cast:',
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: cast.map((actor) {
                                          final String name = actor.name;
                                          final String? profilePath = actor.profilePath;

                                          return Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: profilePath != null
                                                      ? NetworkImage('https://image.tmdb.org/t/p/w200$profilePath')
                                                      : const NetworkImage('https://is.gd/WaIeXL'),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Dear user, unfortunately we do not have the movie\'s cast.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                );
                              }
                            }

                            return const CircularProgressIndicator();
                          },
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to fetch movie details'));
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),






          ],
        ),
      ),
    );
  }
}
