import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/Users_ui/dashboard.dart';
import 'package:get_space_ticket/Users_ui/edit_profile.dart';
import 'package:get_space_ticket/login_signup/ui/auth/login_screen.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:image_picker/image_picker.dart';
import '../login_signup/ui/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;
  late String url;
  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
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
                    String birth = map!['birth'].toString();
                    final age =
                        (DateTime.now().year.toInt()) - int.parse(birth);
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
                                              child: map['profileImage']
                                                          .toString() ==
                                                      ""
                                                  ? const Icon(Icons.person)
                                                  : Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(map[
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
                                        map['userName'],
                                        style: Styles.headLineStyle2,
                                      ),
                                      Text(
                                        map['email'],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 30,
                                width: 165,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  child: const Text('Health Report'),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 500,
                                            child: Dashboard(status: 85,),
                                          );
                                        });
                                  },
                                )),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 165,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(5),
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
                                            const EditProfile()));
                              },
                            )
                          ],
                        ),
                        const Gap(10),
                        const Text(
                          'Personal Info:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(10),
                        Container(
                          height: 420,
                          decoration: BoxDecoration(
                              color: Styles.bgColor,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Full Name: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      map['userName'] ?? 'N/A',
                                    )
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    const Text(
                                      "Father's Name: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(map['fatherName'] ?? 'N/A')
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    const Text(
                                      "Mother's Name: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(map['motherName'] ?? 'N/A')
                                  ],
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Birth year: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(map['birth'] ?? 'N/A')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Age: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(age.toString())
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                Row(
                                  children: [
                                    const Text(
                                      'Gender: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(map['gender'] ?? 'N/A')
                                  ],
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Height:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(map['height'] ?? 'N/A'),
                                        const Text(' Feet')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Wight:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(map['wight'] ?? 'N/A'),
                                        const Text(' Kg')
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Permanent Address: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(map['address'] ?? 'N/A')
                                  ],
                                ),
                                const Gap(20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Present Address: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(map['presentAddress'] ?? 'N/A'),
                                    Gap(20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: SizedBox(
                                        height: 20,
                                        width: 200,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all(const Color(
                                                  0xff014807)),
                                            ),
                                            child: const Text('Apply for Training'),
                                            onPressed: () {
                                              Utils().toastMessages('Apply Successful');
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return const SizedBox(
                                                      height: 500,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.mark_email_read,color: Colors.green,size: 50,),
                                                          Text('Apply Successful',style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 30
                                                          ),),
                                                          Gap(10),
                                                          Text('We will contact with you',style: TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 20)),
                                                          Text('for Training',style: TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 20)),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Gap(10),
                              ],
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
