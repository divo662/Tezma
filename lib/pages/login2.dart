import 'package:flutter/material.dart';
import 'package:movie_app/pages/Mainpage.dart';
import 'package:movie_app/pages/register.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool obscureText = true;
  bool isLoading = false;
  bool isButtonEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailNameEditingController = TextEditingController();
  final passwordNameEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in to continue!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      wordSpacing: 1.3,
                      color: Colors.grey.shade600),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: () {
                      setState(() {
                        isButtonEnabled = _formKey.currentState!.validate();
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                    top: BorderSide.none,
                                    left: BorderSide.none,
                                    right: BorderSide.none,
                                    bottom: BorderSide(
                                        color: Colors.white,
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.005))),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              autofocus: true,
                              controller: firstNameEditingController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username is required!";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                firstNameEditingController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.width *
                                          0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  border: InputBorder.none),
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                    top: BorderSide.none,
                                    left: BorderSide.none,
                                    right: BorderSide.none,
                                    bottom: BorderSide(
                                        color: Colors.white,
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.005))),
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              autofocus: true,
                              obscureText: _obscureText,
                              controller: passwordNameEditingController,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

                                if (value!.isEmpty) {
                                  return 'Password is required';
                                }

                                if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid password'
                                      ' (Min. 6 characters, with at least one'
                                      ' uppercase letter, one lowercase letter,'
                                      ' and one digit)';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                passwordNameEditingController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  ),
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  border: InputBorder.none),
                            )),
                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                Center(
                  child:  GestureDetector(
                    onTap: isButtonEnabled && !isLoading
                        ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
                    }
                        : null,
                    child: Opacity(
                      opacity: isButtonEnabled && !isLoading ? 1.0 : 0.5,
                      child: Container(
                        height: 47,
                        width: 340,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.black,
                        ),
                        child: isLoading
                            ? const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Row(
                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                            SizedBox(width: 79),
                            Text(
                              " Login Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Center(
                    child: Text(
                      "Don't have an Account? Register Now.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
