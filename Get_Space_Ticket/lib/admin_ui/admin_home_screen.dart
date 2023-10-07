import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../utils/ticket_view.dart';
import 'add_post.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("post");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Light',
                            textStyle: const TextStyle(
                                fontSize: 45.0,
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
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Expanded(
                child: FirebaseAnimatedList(
                    scrollDirection: Axis.vertical,
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            child: TicketView(
                              photo: snapshot.child('image').value.toString(),
                              formAdd: snapshot.child('fromAdd').value.toString(),
                              toAdd: snapshot.child('toAdd').value.toString(),
                              space: snapshot.child('spaceName').value.toString(),
                              price: snapshot.child('price').value.toString(),
                              launceDate:
                                  snapshot.child('lunchingDate').value.toString(),
                            ),
                            onTap: () {},
                          ));
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPost()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
