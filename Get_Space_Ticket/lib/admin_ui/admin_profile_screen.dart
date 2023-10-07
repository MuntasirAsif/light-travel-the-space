import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/admin_ui/edit_admin_profile.dart';
import 'package:get_space_ticket/login_signup/ui/auth/login_screen.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:image_picker/image_picker.dart';
import '../login_signup/ui/utils/utils.dart';
import '../utils/pdf_viewer.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  bool loading = false;
  late String url;
  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadPic(_image!);
      } else {
        Utils().toastMessages('No image Selected');
      }
    });
  }

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
    return SafeArea(
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
                    final Map<dynamic, dynamic>? map =
                        data.value as Map<dynamic, dynamic>?;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                          width: 118,
                                          height: 118,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black87,
                                                  width: 3)),
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              child: map?['profileImage']
                                                  .toString() ==
                                                  ""
                                                  ? const Icon(Icons.person)
                                                  : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(map?[
                                                  'profileImage'])))),
                                      InkWell(
                                        onTap: () {
                                          getImageGallery();
                                        },
                                        child: const CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.black,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        map?['companyName'],
                                        style: Styles.headLineStyle2,
                                      ),
                                      Text(
                                        map?['email'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      const Gap(7),
                                      Row(
                                        children: [
                                          const Text(
                                            'User ID: ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            uid.toString(),
                                            style: const TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        InkWell(
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditAdminProfile()));
                          },
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Company Name :',
                              style: Styles.headLineStyle5,
                            ),
                            Text(
                              map?['companyName'],
                              style: Styles.textStyle2,
                            )
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Established : ',
                              style: Styles.headLineStyle5,
                            ),
                            Text(
                              map?['established'],
                              style: Styles.textStyle2,
                            )
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'License Status : ',
                              style: Styles.headLineStyle5,
                            ),
                            Text(
                              map?['status'] ?? 'Pending',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location : ',
                              style: Styles.headLineStyle5,
                            ),
                            Text(
                              map?['location'],
                              style: Styles.textStyle2,
                            )
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contact Number : ',
                              style: Styles.headLineStyle5,
                            ),
                            Text(
                              map?['contactNo'] ?? 'N/A',
                              style: Styles.textStyle2,
                            )
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Website : ',
                              style: Styles.headLineStyle5,
                            ),
                            Text(
                              map?['website'] ?? 'N/A',
                              style: Styles.textStyle2,
                            )
                          ],
                        ),
                        const Gap(10),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfView(pdfUrl: map?['licence'],)));
                            },
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 180,
                                    width: 250,
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Image.asset(
                                      'assets/images/pdf.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const Gap(5),
                                  Center(
                                    child: Text(
                                      ' License ${uid!}.pdf',
                                      style: Styles.headLineStyle5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        Center(
                          child: InkWell(
                            onTap: () {
                              _auth.signOut().then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                                Utils().toastMessages('Log Out Successfully');
                              }).onError((error, stackTrace) {
                                Utils().toastMessages(error.toString());
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 165,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout_sharp,
                                    color: Colors.white,
                                  ),
                                  Gap(10),
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Text('Wrong Something');
                  }
                },
              )),
        ),
      ),
    );
  }

  uploadPic(File image) async {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child("image $uid");
    UploadTask uploadTask = storageRef.putFile(image);
    Future.value(uploadTask).then((value) async {
      url = await storageRef.getDownloadURL();
      addPost(url);
    }).catchError((onError) {
      Utils().toastMessages(onError);
    });
  }

  void addPost(String url) {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    ref.child(uid!).update({
      'profileImage': url,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessages('Profile image updated');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessages(error.toString());
    });
  }
}
