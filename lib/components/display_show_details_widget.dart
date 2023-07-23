import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/movie_api.dart';
import '../models/movie_model.dart';
import '../pages/splash_screen_page.dart';

class ShowDetailsWidget extends StatefulWidget {
  final int movieId;
  final TvShowModel showDetails; // Update type to MovieModel
  final List<CastModel> showCast; // Update type to List<MovieModel>

  const ShowDetailsWidget({
    Key? key,
    required this.movieId,
    required this.showDetails,
    required this.showCast,
  }) : super(key: key);

  @override
  State<ShowDetailsWidget> createState() => _ShowDetailsWidgetState();
}

class _ShowDetailsWidgetState extends State<ShowDetailsWidget> {
  @override
  void initState() {
    super.initState();
    // Remove the unnecessary late Future declarations
  }
  @override
  Widget build(BuildContext context) {
    final int movieId = widget.movieId;
    return  Scaffold(
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
            Container(
              height: 40,
              width: 43,
              decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.bookmark,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            FutureBuilder<TvShowModel>(
              future: fetchShowDetails(movieId),
              builder: (BuildContext context, AsyncSnapshot<TvShowModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final showDetails = snapshot.data!;
                    List<GenreModel>? genres = showDetails.genres;

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
                                  'https://image.tmdb.org/t/p/w500${showDetails.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                          showDetails.name,
                                          style:  TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo.shade400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_sharp,
                                            color: Colors.blue.shade900,
                                          ),
                                          Text(
                                            '${showDetails.voteAverage}',
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
                                  const SizedBox(height: 10),
                                  Text(
                                    'Genres: ${genres?.map((genre) => genre.name).join(', ')}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Status: ${showDetails.status ?? 'N/A'}",
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Description:",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    showDetails.overview ?? '',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
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
                                            showDetails.firstAirDate != null
                                                ? DateFormat('MMMM d, y').format(showDetails.firstAirDate!)
                                                : 'N/A',
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
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FutureBuilder<List<CastModel>>(
                            future: fetchShowCast(movieId),
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
                                            final String profilePath = actor.profilePath;

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
                                } else {
                                  return Text(
                                    'Dear user, unfortunately, we do not have the TV show cast.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                    ),
                                  );
                                }
                              } else {
                                return Center(child: const CircularProgressIndicator());
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to fetch TV show details'));
                  }
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),



          ]
        ),
      ),
    );
  }
}
