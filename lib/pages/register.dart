import 'package:flutter/material.dart';
import 'package:movie_app/pages/login2.dart';
import 'package:movie_app/pages/splash_screen_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign up to get started.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
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
                              controller: emailNameEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Your Email";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                emailNameEditingController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "Email",
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
                              textInputAction: TextInputAction.next,
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
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                    top: BorderSide.none,
                                    left: BorderSide.none,
                                    right: BorderSide.none,
                                    bottom: BorderSide(
                                        color: Colors.white, width: 1.5))),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              autofocus: true,
                              obscureText: obscureText,
                              controller: confirmPasswordEditingController,
                              validator: (value) {
                                if (confirmPasswordEditingController.text !=
                                    passwordNameEditingController.text) {
                                  return "Password doesn't match";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                confirmPasswordEditingController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.vpn_key,
                                      color: Colors.white),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  hintText: "Confirm Password",
                                  hintStyle: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  border: InputBorder.none),
                            )),
                      ],
                    )),
                const SizedBox(height: 30,),
                Center(
                  child: GestureDetector(
                    onTap: isButtonEnabled && !isLoading ? () {} : null,
                    child: Opacity(
                      opacity: isButtonEnabled && !isLoading ? 1.0 : 0.5,
                      child: Container(
                        height: 47,
                        width: 340,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey.shade800,
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
                                    Icons.how_to_reg_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 79),
                                  Text(
                                    " Register Now",
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
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Center(
                    child: Text(
                      "Have an Account? Login Now.",
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
