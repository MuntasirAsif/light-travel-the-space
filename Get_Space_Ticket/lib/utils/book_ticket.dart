import 'package:barcode_widget/barcode_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';

class BookTicket extends StatelessWidget {
  final String bookingCode;
  final String launchingID;

  BookTicket({
    Key? key,
    required this.bookingCode,
    required this.launchingID,
  }) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
      'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref("post");
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return StreamBuilder(
      stream: ref.child(launchingID.toString()).onValue,
      builder:
          (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final DataSnapshot data = snapshot.data!.snapshot;
          final Map<dynamic, dynamic>? map =
          data.value as Map<dynamic, dynamic>?;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [const Text("From"), const Gap(5), Text(map?['fromAdd'])],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '- - - - -  ',
                                  style: Styles.headLineStyle2,
                                ),
                                const Icon(Icons.rocket_launch_rounded),
                                Text(
                                  '  - - - - -',
                                  style: Styles.headLineStyle2,
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [const Text("To"), const Gap(5), Text(map?['toAdd'])],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black54,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Muntasir Ashif',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Gap(5),
                            Text('Name')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'N/A',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Gap(5),
                            Text('Occupation')
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    const Text(
                      'Details',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black87,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              map?['lunchingDate'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(5),
                            const Text('Launching Date')
                          ],
                        ),
                        const Column(
                          children: [
                            Text(
                              '8:00 AM',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Gap(5),
                            Text('Time')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              map?['returningDate'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Gap(5),
                            Text('Returning Date')
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              map?['spaceName'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(5),
                            const Text('Space')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              map?['lunchCode'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(5),
                            const Text('Launch Code')
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          children: [
                            Text(
                              'Tourism',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Gap(5),
                            Text('Purpose')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              bookingCode,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(5),
                            const Text('Booking Code')
                          ],
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(height: 30, width: 60, child: Text('Paid',style: TextStyle(
                                  fontSize: 26,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold
                                ),)),
                                Text(
                                  '******126',
                                  style: Styles.headLineStyle3,
                                )
                              ],
                            ),
                            const Gap(5),
                            const Text('Payment Status')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "\$"+map?['price'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(5),
                            const Text('Price')
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    SizedBox(
                      height: 90,
                      width: 400,
                      child: BarcodeWidget(
                        data: 'LunchCode $launchingID Booking $bookingCode',
                        barcode: Barcode.code128(),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(10),
            ],
          );
        } else {
          return const Text('Wrong Something');
        }
      },
    );
  }
}
