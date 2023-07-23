import 'package:flutter/material.dart';
import 'package:movie_app/pages/Mainpage.dart';
import 'package:movie_app/pages/login.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

class OnboardScreenPage extends StatefulWidget {
  const OnboardScreenPage({Key? key}) : super(key: key);

  @override
  State<OnboardScreenPage> createState() => _OnboardScreenPageState();
}

class _OnboardScreenPageState extends State<OnboardScreenPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  List<String> imagePath = [
    "images/shazam-fury-of-the-gods-movie-poster.jpg",
    "images/aquaman.jpg",
    "images/creed.jpg",
    "images/infinity.jpg",
    "images/john.jpg",
  ];
  final List<Map<String, String>> movie = [
    {
      "title": "Discover new movies",
      "description": "Find the latest movies and TV shows available for streaming on Tezma"
    },
    {
      "title": "Personalized recommendations",
      "description": "Get personalized recommendations based on your viewing history"
    },
    {
      "title": "Enjoy unlimited access",
      "description": "With Tezma, you get unlimited access to thousands of movies, TV shows, and documentaries."
    },
    {
      "title": "Stream anytime, anywhere",
      "description": "Stream your favorite movies and TV shows anytime, anywhere"
    },
    {
      "title": "Join the Tezma community",
      "description": "Join the Tezma community today by signing up and enjoying box buster movies!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54.withBlue(34),
      body: PageView.builder(
        controller: _pageController,
        itemCount: imagePath.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              backgroundBlendMode: BlendMode.darken,
              image: DecorationImage(
                opacity: 0.6,
                filterQuality: FilterQuality.high,
                alignment: Alignment.topCenter,
                image: AssetImage(
                  imagePath[index],
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.479),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4474,
                    width: MediaQuery.of(context).size.width * 1.074,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                      color: Colors.black.withBlue(800),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 60,
                          offset: const Offset(3, 7),
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SingleChildScrollView( // Wrap with SingleChildScrollView
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                    (index) => Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == index ? Colors.white : Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              movie[index]['title'] ?? "",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.08,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16), // Adjust the height according to your needs
                            Center(
                              child: Text(
                                movie[index]['description'] ?? "",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16), // Adjust the height according to your needs
                            Center(
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: _currentIndex == 4 ? 1.0 : 0.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return const LoginPage();
                                    }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.indigo,
                                  ),
                                  child: const Text('Get Started'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16), // Adjust the height according to your needs
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedOpacity(
                                  opacity: _currentIndex == 4 ? 0.0 : 1.0,
                                  duration:const Duration(milliseconds: 300),
                                  child: IconButton(
                                    onPressed: () {
                                      if (_currentIndex > 0) {
                                        _pageController.previousPage(
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: _currentIndex == 4 ? 0.0 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: IconButton(
                                    onPressed: () {
                                      if (_currentIndex < 4) {
                                        _pageController.nextPage(
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward, color: Colors.white60),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

