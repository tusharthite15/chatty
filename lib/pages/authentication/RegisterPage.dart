import 'package:chattingapp/helping/helper_fun.dart';
import 'package:chattingapp/pages/authentication/login.dart';
import 'package:chattingapp/services/auth-service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../Homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ))
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 80),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "GroupY",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),

                          const Text("Create your account to chat and explore",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              )),

                          Image.asset(
                              "asset/social-media-marketing-online-communication-concept-social-media-marketing-online-communication-concept-people-173712753.jpg"),

                          //registration info
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              labelText: "Full Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // for name validation
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return "Name can't be empty";
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                fullName = val;
                                print(fullName);
                              });
                            },
                          ),

                          const SizedBox(height: 15),

                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // for email validation
                            //validation for email regarding its existence
                            validator: (val) {
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter valid email address";
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                                print(email);
                              });
                            },
                          ),
                          //for the password section
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            //validation for password regarding its size
                            validator: (val) {
                              if (val!.length < 6) {
                                return "Password must be atleast 6 character";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                password = val;
                                print(password);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              onPressed: () {
                                Register();
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                                text: "Already have an account?",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Login now",
                                    style: const TextStyle(color: Colors.black),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        nextScreen(context, const LoginPage());
                                      },
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ))));
  }

  Register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          //saving the sharred function state
          await HelperFunction.saveUSerLoggedInStatus(true);
          await HelperFunction.saveUSerEmailSF(email);
          await HelperFunction.saveUSerNameSF(fullName);
           nextScreenReplace(context, const HomePage());

        } else {
          showSnackBar(context, Colors.red, value);
          _isLoading = false;
        }
      });
    }
  }
}
