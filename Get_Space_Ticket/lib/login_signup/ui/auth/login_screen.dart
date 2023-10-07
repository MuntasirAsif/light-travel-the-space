// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/Users_ui/bottom_bar.dart';
import 'package:get_space_ticket/login_signup/ui/auth/sign_up_screen.dart';

import '../../../admin_ui/admin_bar.dart';
import '../../widget/round_button.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Check if a user is logged in
    if (user != null) {
      DatabaseReference userRef = FirebaseDatabase.instanceFor(
              app: Firebase.app(),
              databaseURL:
                  'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
          .ref("user")
          .child(user.uid);

      userRef.once().then((DatabaseEvent event) {
        if (event.snapshot.value != null) {
          Map<dynamic,dynamic> userData = event.snapshot.value as dynamic;


          String? userRole = userData['userType'];

          // Use a try-catch block to handle errors during navigation
          try {
            if (userRole == "Company") {
              // Use `pushReplacement` to replace the current screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CompanyBar(),
                ),
              );
            } else {
              // Use `pushReplacement` to replace the current screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const bottomBar(),
                ),
              );
            }
          } catch (e) {
            print("Error navigating: $e");
          }
        } else {
          print("User data not found");
        }
      });
    } else {
      print("User not logged in");
    }
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text.toString())
        .then((value) {
      route(context);
      Utils().toastMessages('login Successfully');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessages(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'Light',
                                  textStyle: const TextStyle(
                                      fontSize: 40.0,
                                      fontFamily: 'Horizon',
                                      fontWeight: FontWeight.bold),
                                  colors: colorizeColors,
                                ),
                              ],
                              isRepeatingAnimation: true,
                              repeatForever: true,
                            ),
                          ),
                          const Text(
                            'Travels With speed of Light',
                            style: TextStyle(fontSize: 8),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Gap(70),
                  const Text(
                    'Login Account',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: 'Email',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black)),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                          ),
                          const Gap(10),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_open),
                              hintText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ],
                      )),
                  const Gap(40),
                  RoundButton(
                    title: 'Login',
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text('Sign-up'))
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
