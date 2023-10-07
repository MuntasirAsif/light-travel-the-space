
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_space_ticket/Users_ui/bottom_bar.dart';
import '../../admin_ui/admin_bar.dart';
import '../ui/auth/login_screen.dart';

class SplashServices{
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
  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user == null) {
      Timer(
          const Duration(seconds: 4),
              () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }
    else{
      Timer(
          const Duration(seconds: 4),
              () => route(context));
    }
  }
}