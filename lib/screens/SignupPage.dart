import 'package:flutter/material.dart';
import 'package:possi_build/components/textffWidget.dart';
import 'package:possi_build/screens/SigninPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  final _focusUserName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focuscnfPassword = FocusNode();
  final _focusName = FocusNode();

  bool _rembemberMe = false;
  bool _isProcessing = false;
  String url = 'https://api-telly-tell.herokuapp.com/api/client/signup';

  Future createUser(
      String firstName, String lastName, String email, String password) async {
    // UserModel userData = UserModel(
    //     firstName: firstName,
    //     lastName: lastName,
    //     email: email,
    //     password: password);
    Map<String, String> userData = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focuscnfPassword.unfocus();
        _focusUserName.unfocus();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // height: 850,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 245, 245, 245),
              ),
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 35, bottom: 15),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _registerFormKey,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "We Are Excited to\nOnboard you",
                            style: TextStyle(
                              // color: Color.fromARGB(
                              // 255, 235, 235, 235),
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                          const SizedBox(
                            height: 25,
                          ),
                          TextffWidget(
                            controller: nameController,
                            focus: _focusName,
                            hintText: "",
                            labelText: "Your Name",
                            icon: Icons.person,
                            isPassword: false,
                            isUsername: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextffWidget(
                            controller: emailController,
                            focus: _focusEmail,
                            hintText: "abc@gmail.com",
                            labelText: "Email Address",
                            icon: Icons.person,
                            isPassword: false,
                            isUsername: false,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextffWidget(
                            controller: usernameController,
                            focus: _focusUserName,
                            hintText: "amansingh1",
                            labelText: "Username",
                            icon: Icons.person,
                            isPassword: false,
                            isUsername: true,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextffWidget(
                              controller: passwordController,
                              focus: _focusPassword,
                              hintText: "abc%#123",
                              labelText: "Password",
                              icon: Icons.verified_user_outlined,
                              isPassword: true,
                              isUsername: false),
                          const SizedBox(
                            height: 15,
                          ),
                          TextffWidget(
                              controller: confirmPasswordController,
                              focus: _focuscnfPassword,
                              hintText: "Confrom Password",
                              labelText: "Confirm Password",
                              icon: Icons.verified_user_outlined,
                              isPassword: true,
                              isUsername: false),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: _rembemberMe,
                                onChanged: (bool? newValue) => setState(
                                  () {
                                    _rembemberMe = newValue!;
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                          "By Signing up you are accept the",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      SizedBox(
                                        height: 30,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "./signin");
                                          },
                                          child: const Text("Term and Service",
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("and",
                                          style: TextStyle(
                                            fontSize: 12,
                                            // color: Color.fromARGB(
                                            // 255, 211, 211, 211),
                                          )),
                                      SizedBox(
                                        // width: 250,
                                        height: 30,
                                        child: TextButton(
                                          onPressed: () {
                                            // Navigator.pushNamed(
                                            // context, "./signin");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (content) =>
                                                    const SignUp(),
                                              ),
                                            );
                                          },
                                          child: const Text("Privacy Policy",
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          if (_isProcessing)
                            const CircularProgressIndicator()
                          else
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35)),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_registerFormKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      _isProcessing = true;
                                    });
                                    try {
                                      final userModel = createUser(
                                          nameController.text
                                              .split(" ")[0]
                                              .toString(),
                                          nameController.text
                                              .split(" ")[1]
                                              .toString(),
                                          emailController.text,
                                          passwordController.text);
                                      if (userModel != null) {
                                        Navigator.pushNamed(
                                            context, '/signin/');
                                      }
                                    } catch (e) {
                                      throw Exception(e);
                                    }
                                    setState(() {
                                      _isProcessing = false;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  primary:
                                      const Color.fromARGB(255, 43, 47, 51),
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
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
                          "Already have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
                          },
                          child: const Text("Sign in"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
