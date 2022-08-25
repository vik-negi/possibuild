import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:possi_build/NavigationPage.dart';
import 'package:possi_build/components/textContainer.dart';
import 'package:possi_build/components/textffWidget.dart';
import 'package:possi_build/models/userModel.dart';
import 'package:possi_build/screens/SignupPage.dart';
import 'package:possi_build/utils/validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Map mapResponce = {};
  Map userData = {};

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  // late final AuthProvider provider;

  bool _isProcessing = false;
  bool _rembemberMe = false;
  bool _showPassword = false;

  String url = 'https://api-telly-tell.herokuapp.com/api/client/signin';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 245, 245, 245),
          ),
          margin:
              const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 15),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const TextContainer(
                        text: "Welcom Back",
                        fontweight: FontWeight.w500,
                        size: 32,
                      ),
                      const TextContainer(
                        text: "Great to see you again",
                        fontweight: FontWeight.w500,
                        size: 18,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const TextContainer(
                          text: "Sign In ",
                          fontweight: FontWeight.w500,
                          size: 30),
                      const SizedBox(
                        height: 25,
                      ),
                      TextffWidget(
                        controller: emailController,
                        focus: _focusEmail,
                        hintText: 'abcd@gmail.com',
                        icon: Icons.person,
                        labelText: 'Email Addresss',
                        isPassword: false,
                        isUsername: false,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: _showPassword ? false : true,
                        focusNode: _focusPassword,
                        validator: (value) =>
                            Validator.validatePassword(password: value!),
                        controller: passwordController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Password",
                          errorBorder: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.verified_user_outlined,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _showPassword
                                    ? const Color(0xffa1a1a1)
                                    : const Color(0xffffffff),
                              )),
                          labelText: "Password",
                          filled: true,
                          fillColor: const Color.fromARGB(255, 43, 47, 51),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rembemberMe,
                                onChanged: (bool? newValue) => setState(
                                  () {
                                    _rembemberMe = newValue!;
                                  },
                                ),
                              ),
                              const Text(
                                "Remember Me",
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forget Password",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Material(
                        borderRadius: _isProcessing
                            ? BorderRadius.circular(50)
                            : BorderRadius.circular(35),
                        child: ElevatedButton(
                            onPressed: () async {
                              _focusEmail.unfocus();
                              _focusPassword.unfocus();

                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isProcessing = true;
                                });
                                // final user = await
                                signinUser(emailController.text,
                                    passwordController.text);
                                // if (user != null) {
                                //   await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: ((context) => NavigatorMenu(
                                //             userModel: user,
                                //           )),
                                //     ),
                                //   );
                                // }

                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              primary: const Color.fromARGB(255, 43, 47, 51),
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 1000),
                              width: _isProcessing
                                  ? 50
                                  : MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              child: _isProcessing
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            )),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 2,
                            width: 0.4 * MediaQuery.of(context).size.width,
                            color: const Color.fromARGB(255, 80, 80, 80),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 1.5),
                            child: const Text(
                              "or",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 0.4 * MediaQuery.of(context).size.width,
                            color: const Color.fromARGB(255, 80, 80, 80),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 10),
                      Center(
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do not have accoutn?",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, "./signup");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (content) => const SignUp(),
                          ),
                        );
                      },
                      child: const Text("Sign up"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future signinUser(String email, String password) async {
    Map userData = {
      "email": email,
      "password": password,
    };

    http.Response response = await http.post(Uri.parse(url), body: userData);
    mapResponce = await json.decode(response.body);
    if (mapResponce["userData"] != null) {
      userData = mapResponce["userData"];
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      UserModel userModel = UserModel(
        firstName: userData['firstName'],
        lastName: userData['lastName'],
        email: userData['email'],
        password: userData['password'],
      );
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => NavigatorMenu(
                userModel: userModel,
                userdata: userData,
              )),
        ),
      );

      // return userModel;
    } else if (mapResponce["userData"] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mapResponce["message"].toString())));
    }

    setState(() {
      _isProcessing = false;
    });
  }
}
