import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/Users_ui/profile_screen.dart';
import 'package:get_space_ticket/utils/app_styles.dart';

import '../login_signup/ui/utils/utils.dart';
import '../login_signup/widget/round_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool loadingStatus = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final fatherController = TextEditingController();
  final motherController = TextEditingController();
  final birthController = TextEditingController();
  final ganderController = TextEditingController();
  final heightController = TextEditingController();
  final wightController = TextEditingController();
  final presentAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();

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
    late double k;
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
                      nameController.text = map?['userName']?? 'N/A';
                      fatherController.text = map?['fatherName'] ?? 'N/A';
                      motherController.text = map?['motherName']?? 'N/A';
                      birthController.text = map?['birth']?? 'N/A';
                      ganderController.text =map?['gender']?? 'N/A';
                      heightController.text = map?['height']?? '5.6';
                      wightController.text = map?['wight']?? '70';
                      presentAddressController.text = map?['presentAddress']?? 'N/A';
                      permanentAddressController.text = map?['address']?? 'N/A';
                      if(ganderController.text=='Male'){
                        k = 0;
                      }else if(ganderController.text=='Female'){
                        k =1;
                      }else{
                        k=2;
                      }
                      return Column(
                        children: [
                          const Gap(30),
                          Center(
                              child: Text(
                            'Edit Your Info.',
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
                                    keyboardType: TextInputType.text,
                                    controller: fatherController,
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
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Father Name',
                                        hintText: 'Father Name',
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
                                    controller: motherController,
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
                                        hintText: 'Mother Name',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Mother Name',
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
                                    controller: birthController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        loadingStatus = true;
                                        return 'Birth Year';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.calendar_month_rounded),
                                        hintText: 'Birth Year',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Birth Year',
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
                                  Row(
                                    children: [
                                      const Text("Gander: ",style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
                                      CustomRadioButton(
                                        width: 90,
                                        elevation: k,
                                        absoluteZeroSpacing: true,
                                        unSelectedColor: Theme.of(context).canvasColor,
                                        buttonLables: const [
                                          'Male',
                                          'Female',
                                          'Others',
                                        ],
                                        buttonValues: const [
                                          "Male",
                                          "Female",
                                          "Others",
                                        ],
                                        unSelectedBorderColor: Colors.black,
                                        selectedBorderColor: Colors.orangeAccent,
                                        buttonTextStyle: const ButtonTextStyle(
                                            selectedColor: Colors.white,
                                            unSelectedColor: Colors.black,
                                            textStyle: TextStyle(fontSize: 16)),
                                        radioButtonValue: (value) {
                                          ganderController.text = value;
                                        },
                                        selectedColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                  const Gap(30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 170,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: wightController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              loadingStatus = true;
                                              return 'Enter Weight';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                              prefixIcon:
                                              Icon(Icons.height),
                                              hintText: 'Weight',
                                              labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                              labelText: 'Weight (Kg)',
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      width: 2, color: Colors.black)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: heightController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              loadingStatus = true;
                                              return 'Enter Height';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                              prefixIcon:
                                              Icon(Icons.monitor_weight_outlined),
                                              hintText: 'Height',
                                              labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                              labelText: 'Height (Feet)',
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)),
                                                  borderSide: BorderSide(
                                                      width: 2, color: Colors.black)),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(20),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: presentAddressController,
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
                                  const Gap(20),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: permanentAddressController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        loadingStatus = true;
                                        return 'Enter Address';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                        Icon(Icons.location_city_sharp),
                                        hintText: 'Permanent address',
                                        labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                                        labelText: 'Permanent address',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.black)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)))),
                                  ),
                                  const Gap(10),
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
      'userName': nameController.text,
      'fatherName': fatherController.text,
      'motherName' : motherController.text,
      'birth': birthController.text,
      'gender': ganderController.text,
      'height':heightController.text,
      'wight':wightController.text,
      'presentAddress': presentAddressController.text,
      'address' : permanentAddressController.text,
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
