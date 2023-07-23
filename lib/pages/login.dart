import 'package:flutter/material.dart';
import 'package:movie_app/pages/login2.dart';
import 'package:movie_app/pages/register.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.23),
                 Center(
                   child: Text("Tezma",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4
                ),),
                 ),
                Center(
                  child: Text(
                    "Access to unlimited movies and tv shows",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: Colors.grey.shade600),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.77,
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.indigo
                      ),
                      child: Center(
                        child: Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * 0.065,
                              fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const RegisterPage();
                      }));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.77,
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                      ),
                      child: Center(
                        child: Text("Register",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: MediaQuery.of(context).size.width * 0.061,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                    ),
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
