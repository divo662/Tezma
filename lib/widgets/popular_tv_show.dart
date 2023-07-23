import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/movie_api.dart';
import '../components/display_show_details_widget.dart';
import '../models/movie_model.dart';
import '../pages/splash_screen_page.dart';

class PopularTvShowWidget extends StatefulWidget {
  const PopularTvShowWidget({Key? key}) : super(key: key);

  @override
  State<PopularTvShowWidget> createState() => _PopularTvShowWidgetState();
}

class _PopularTvShowWidgetState extends State<PopularTvShowWidget> {
  TextEditingController controller = TextEditingController();
  int currentPage = 1;
  String? errorMessage;
  String? _searchQuery;
  List<TvShowModel> _tvShows = []; // Changed to TvShowModel

  Future<List<TvShowModel>> fetchPopularTvShows1({int page = 1, String? query}) async {
    const apiKey = '9ee736e148e808222f04c1535dc80b64';
    final url = query == null
        ? 'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&page=1&language=en-US'
        : 'https://api.themoviedb.org/3/search/tv?api_key=$apiKey&query=$query&page=1&language=en-US';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null) {
        final List<dynamic> results = data['results'];
        final List<TvShowModel> tvShows = results.map((result) {
          return TvShowModel(
            tvShowID: result['id'],
            name: result['name'],
            posterPath: result['poster_path'] ?? "",
            overview: result['overview'] ?? "",
            tagline: result['tagline'] ?? "",
            status: result['status'] ?? "",
            genres: [], // You can include the genres if available
            voteAverage: result['vote_average'].toDouble(),
            firstAirDate: DateTime.parse(result['first_air_date']), // Update here
            releaseDate: result['release_date'] ?? "",
          );
        }).toList();
        return tvShows;
      }
    }
    throw Exception('Failed to fetch popular TV shows');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Popular Tv Shows'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
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
                hintText: "Search for TV Shows...", // Update here
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
                        _tvShows = []; // Set an empty list to reset the TV shows
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
            child: FutureBuilder<List<TvShowModel>>(
              future: fetchPopularTvShows1(page: currentPage, query: _searchQuery),
              builder: (BuildContext context, AsyncSnapshot<List<TvShowModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Failed to fetch TV shows.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final List<TvShowModel> tvShows = snapshot.data!;

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: tvShows.length,
                    itemBuilder: (BuildContext context, int index) {
                      final TvShowModel tvShow = tvShows[index];
                      final String title = tvShow.name;
                      final String posterPath = tvShow.posterPath;
                      final int tvShowId = tvShow.tvShowID;

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

                            fetchShowDetails(tvShowId)
                                .then((showDetails) {
                              fetchShowCast(tvShowId).then((cast) {
                                // Close the dialog after fetching the data
                                Navigator.of(context,
                                    rootNavigator: true)
                                    .pop();

                                // Perform navigation after the dialog is closed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ShowDetailsWidget(
                                      movieId: tvShowId,
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