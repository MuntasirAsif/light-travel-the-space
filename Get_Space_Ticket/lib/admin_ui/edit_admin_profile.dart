import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import '../login_signup/ui/utils/utils.dart';
import '../login_signup/widget/round_button.dart';

class EditAdminProfile extends StatefulWidget {
  const EditAdminProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<EditAdminProfile> createState() => _EditAdminProfileState();
}

class _EditAdminProfileState extends State<EditAdminProfile> {
  bool loadingStatus = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final establishController = TextEditingController();
  final contactNumberController = TextEditingController();
  final websiteController = TextEditingController();
  final locationController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref("user");
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Styles.bgColor,
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder(
                  stream: ref.child(uid.toString()).onValue,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final DataSnapshot data = snapshot.data!.snapshot;
                      final Map<dynamic, dynamic>? map = data.value as Map<dynamic, dynamic>?;
                      nameController.text = map?['companyName']?? 'N/A';
                      establishController.text = map?['established']?? 'N/A';
                      contactNumberController.text = map?['contactNo']?? 'N/A';
                      websiteController.text = map?['website']?? 'N/A';
                      locationController.text = map?['location']?? 'N/A';
                      return Column(
                        children: [
                          const Gap(30),
                          Center(
                              child: Text(
                            'Edit Company Info.',
                            style: Styles.headLineStyle,
                          )),
                          const Gap(30),
                          Form(
                              key: _formKey,
                              child: Column(
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
                                        prefixIcon:
                                            Icon(Icons.perm_identity_outlined),
                                        hintText: 'Name',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Name',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ),
                                  const Gap(20),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: establishController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        loadingStatus = true;
                                        return 'Established Year';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.calendar_month_rounded),
                                        hintText: 'Established Year',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Established Year',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ),
                                  const Gap(20),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: websiteController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        loadingStatus = true;
                                        return 'Enter Website';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                        Icon(Icons.add_link_rounded),
                                        hintText: 'Website Link',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Website Link',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ),
                                  const Gap(20),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: contactNumberController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        loadingStatus = true;
                                        return 'Enter Contact Number';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                        Icon(Icons.phone),
                                        hintText: 'Contact Number',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Contact Number',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ),
                                  const Gap(20),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: locationController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        loadingStatus = true;
                                        return 'Enter address';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                        Icon(Icons.location_city_sharp),
                                        hintText: 'Present Address',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Present address',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ),
                                  const Gap(30),
                                ],
                              )),
                          RoundButton(
                            title: 'Save',
                            ontap: () {
                              if (_formKey.currentState!.validate()) {
                                addPost();
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return const Text('Wrong Something');
                    }
                  },
                )),
          ),
        ),
      ),
    );
  }
  void addPost() {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    ref.child(uid!).update({
      'companyName': nameController.text,
      'established': establishController.text,
      'contactNo':contactNumberController.text,
      'website':websiteController.text,
      'location': locationController.text,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      Utils().toastMessages('Info. updated');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessages(error.toString());
    });
  }
}
