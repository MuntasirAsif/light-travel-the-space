import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../widget/round_button.dart';
import '../utils/utils.dart';
import 'login_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class CompanySignUp extends StatefulWidget {
  const CompanySignUp({Key? key}) : super(key: key);

  @override
  State<CompanySignUp> createState() => _CompanySignUpState();
}

class _CompanySignUpState extends State<CompanySignUp> {
  String fileName='';
  late File file;
  bool loadingStatus = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  var confirmPass;
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final repassController = TextEditingController();
  final yearController = TextEditingController();
  final locationNameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void signUp() {
    _auth
        .createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passController.text.toString(),
    )
        .then((value) {
      uploadLicence(fileName,file).toString();

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

  void addDetails(String licence) async{
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    ref.child(uid!).set({
      'userType': 'Company',
      'companyName': companyNameController.text.toString(),
      'email': emailController.text.toString(),
      'licence' : licence,
      'established':yearController.text.toString(),
      'location' :locationNameController.text.toString(),
      'contactNo':'',
      'website':'',
      'profileImage':'',
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

  uploadLicence(String fileName, File file) async{
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    final licenceRef = FirebaseStorage.instance.ref().child("Licence/$uid.pdf");
    final uploadTask = licenceRef.putFile(file);
    Future.value(uploadTask).then((value) async {
      final downloadLink = await licenceRef.getDownloadURL();
      addDetails(downloadLink);
    }).catchError((onError) {
      Utils().toastMessages(onError);
    });
  }
  void  pickFile() async{
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if(pickedFile != null){
      setState(() {
        fileName = pickedFile.files[0].name;
        file = File(pickedFile.files[0].path!);
      });
    }
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
                          controller: companyNameController,
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
                              hintText: 'Company Name',
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
                          controller: yearController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Year';
                            } else if((int.parse(value)) < 1700 || (int.parse(value)) >= 2023){
                              return '1700 - 2023';
                          }  else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month_rounded),
                              hintText: 'Established Year',
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
                          controller: locationNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              loadingStatus = true;
                              return 'Enter Location';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.location_city),
                              hintText: 'Location',
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
                        InkWell(
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.picture_as_pdf_sharp),
                                  const Gap(10),
                                  Text(fileName!=''?fileName.toString():'Upload Licence or Valid Document'),
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            pickFile();
                          },
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
