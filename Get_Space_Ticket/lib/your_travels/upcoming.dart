import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import '../utils/book_ticket.dart';

class UpcomingTravel extends StatefulWidget {
  const UpcomingTravel({Key? key}) : super(key: key);

  @override
  State<UpcomingTravel> createState() => _UpcomingTravelState();
}

class _UpcomingTravelState extends State<UpcomingTravel> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("user");
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: StreamBuilder(
          stream: ref.child(uid.toString()).child('booking').onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final DataSnapshot data = snapshot.data!.snapshot;
              final Map<dynamic, dynamic>? map =
                  data.value as Map<dynamic, dynamic>?;
              List<dynamic>? list = [];
              list.clear();
              list = map?.values.toList();
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount : list?.length,
                  itemBuilder: (context, index){
                    return  SingleChildScrollView(
                        child: BookTicket(
                          bookingCode: list?[index]['bookingCode'],
                          launchingID: list?[index]['launchingID'],
                          ),
                    );
                  });
            } else {
              return const Text('Wrong Something');
            }
          },
        ),
      ),
    );
  }
}
