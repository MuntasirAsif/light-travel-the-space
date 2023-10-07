import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../widget/round_button.dart';
import '../utils/utils.dart';
import 'login_screen.dart';
class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);


  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  bool loadingStatus = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  var confirmPass;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final repassController = TextEditingController();
  final birthController = TextEditingController();
  final addressController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
  void addDetails() async{
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    ref.child(uid!).set({
      'profileImage':'',
      'userType': 'Simple User',
      'userName': nameController.text.toString(),
      'email': emailController.text.toString(),
      'birth':birthController.text.toString(),
      'address' :addressController.text.toString(),
    }).then((value) {
      setState(() {
        loading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessages(error.toString());
    });
  }
  void signUp(){
    _auth.createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passController.text.toString(),
    ).then((value) {
      addDetails();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      Utils().toastMessages('SignUp Successfully');
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessages(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  DatabaseReference ref = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
      'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Name';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity_outlined),
                              hintText: 'Name',
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
                          keyboardType: TextInputType.number,
                          controller: birthController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Year';
                            } else if((int.parse(value)) < 1950 || (int.parse(value)) >= 2023){
                              return '1950 - 2023';
                            }  else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.calendar_month_rounded),
                              hintText: 'Birth Year',
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
                          keyboardType: TextInputType.text,
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Address';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.location_city_sharp),
                              hintText: 'Address',
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Email';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail_outline_rounded),
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
                            confirmPass = value;
                            if (value!.isEmpty) {
                              loadingStatus = true;
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
                                borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                          ),
                        ),
                        const Gap(10),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: repassController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Re-type Password';
                            } else if (value != confirmPass.toString()) {
                              return 'Password must be same';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock_open),
                            hintText: 'Re-type Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                          ),
                        ),
                      ],
                    )),
                const Gap(20),
                RoundButton(
                  title: 'Sign Up',
                  ontap: () {
                    setState(() {
                      if (loadingStatus) {
                        loading = false;
                      } else {
                        loading = true;
                      }
                    });
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  loading: loading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text('Login'))
                  ],
                ),
                const Gap(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
