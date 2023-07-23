import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/splash_screen_page.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class SearchForMovie extends StatefulWidget {
  const SearchForMovie({Key? key}) : super(key: key);

  @override
  State<SearchForMovie> createState() => _SearchForMovieState();
}

class _SearchForMovieState extends State<SearchForMovie> {
  List<dynamic> _searchResults = [];
  String? _errorMessage;

  Future<List<dynamic>> fetchMovies(String query) async {
    try {
      const apiKey = '9ee736e148e808222f04c1535dc80b64';
      final url = 'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&language=en-US';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          return data['results'];
        }
      }
      throw Exception('Failed to fetch movies');
    } catch (error) {
      throw Exception('Failed to fetch movies: $error');
    }
  }

  void _searchMovies(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _errorMessage = null;
      });
      return;
    }

    fetchMovies(query).then((movies) {
      setState(() {
        _searchResults = movies;
        _errorMessage = null;
      });
    }).catchError((error) {
      setState(() {
        _searchResults = [];
        _errorMessage = 'Error: $error';
      });
    });
  }

  void navigateToDetail(dynamic item) {
    // Add your navigation logic here
    // Example: Navigator.push(...)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 46,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: _searchMovies,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 19,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontSize: 17,
                        ),
                        suffixIcon: const Icon(CupertinoIcons.search),
                        contentPadding: const EdgeInsets.all(7),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (_searchResults.isEmpty && _errorMessage == null)
                const Text('No search has been made, please make a search'),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (_searchResults.isNotEmpty)
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: fetchMovies("query"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Failed to fetch movies'),
                        );
                      }
                      if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No movies found'),
                        );
                      }
                      final movies = snapshot.data!;
                      return ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = movies[index];
                          return ListTile(
                            onTap: () {
                              navigateToDetail(item);
                            },
                            title: Text(item['title']),
                            subtitle: Text(item['overview']),
                            leading: Image.network(
                              'https://image.tmdb.org/t/p/w500/${item['poster_path']}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
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

