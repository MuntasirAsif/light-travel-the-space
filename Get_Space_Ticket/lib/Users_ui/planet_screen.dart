import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';

class PlanetScreen extends StatefulWidget {
  final String name;

  const PlanetScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<PlanetScreen> createState() => _PlanetScreenState(name);
}

class _PlanetScreenState extends State<PlanetScreen> {
  var name;
  int myCurrentIndex = 0;
  _PlanetScreenState(this.name);
  final ideaController = TextEditingController();
  DatabaseReference ref2 = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("Planet");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: StreamBuilder(
        stream: ref2.child(name.toString()).onValue,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final DataSnapshot data = snapshot.data!.snapshot;
            final Map<dynamic, dynamic>? map =
                data.value as Map<dynamic, dynamic>?;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 235,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    ),
                    image: DecorationImage(
                        fit:BoxFit.cover,image: NetworkImage(map?['cover_image_url']))
                  ),),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Center(
                        child: Text(
                          'Name: ',
                          style: Styles.headLineStyle2,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          map?['name'] ?? "N/A",
                          style: Styles.headLineStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                          color: Colors.black12
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20,left: 16,right: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Type: ',
                                  style: Styles.headLineStyle5,
                                ),
                                Text(
                                  map?['type'] ?? "N/A",
                                  style: Styles.textStyle3,
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text(
                                  'Classification: ',
                                  style: Styles.headLineStyle5,
                                ),
                                Text(
                                  map?['classification'] ?? "N/A",
                                  style: Styles.textStyle3,
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text(
                                  'Right Ascension: ',
                                  style: Styles.headLineStyle5
                                ),
                                Text(
                                  map?['rightAscension'] ?? "N/A",
                                  style: Styles.textStyle3
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text(
                                  'Declination: ',
                                  style: Styles.headLineStyle5
                                ),
                                Text(
                                  map?['declination'] ?? 'N/A',
                                  style: Styles.textStyle3
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text(
                                  'Azimuth: ',
                                  style: Styles.headLineStyle5
                                ),
                                Text(
                                  map?['azimuth'] ?? 'N/A',
                                  style: Styles.textStyle3
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text(
                                  'Elevation: ',
                                  style: Styles.headLineStyle5,
                                ),
                                Text(map?['elevation'] ?? 'N/A',
                                    style: Styles.textStyle3),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text('Gravity: ', style: Styles.headLineStyle5),
                                Text(map?['gravity'] ?? 'N/A',
                                    style: Styles.textStyle3),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Text('Distance from Earth: ',
                                    style: Styles.headLineStyle5),
                                Text(
                                  map?['distanceFromEarth'] ?? 'N/A',
                                  style: Styles.textStyle3,
                                ),
                              ],
                            ),
                            const Gap(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Travel time from Earth: ',
                                  style: Styles.headLineStyle5,
                                ),
                                Expanded(
                                  child: Text(
                                    map?['travelTimeFromEarth'] ?? 'N/A',
                                    style: Styles.textStyle3,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Landing Spots: ',
                                  style: Styles.headLineStyle2,
                                ),
                                Text(
                                  map?['landing_spots'] ?? 'N/A',
                                  style: Styles.textStyle3,
                                ),
                                const Gap(10),
                                Text(
                                  'Description: ',
                                  style: Styles.headLineStyle2,
                                ),
                                Text(
                                  map?['description'] ?? 'Updating',
                                  style: Styles.textStyle3,
                                ),
                                const Gap(10),
                                Text(
                                  'Safety Guidelines: ',
                                  style: Styles.headLineStyle2,
                                ),
                                Text(
                                  map?['safety_guidelines'] ?? 'N/A',
                                  style: Styles.textStyle3,
                                ),
                                const Gap(10),
                                Text(
                                  'Tourist Experience',
                                  style: Styles.headLineStyle2,
                                ),
                                Text(
                                  map?['tourist_experience'] ?? 'N/A',
                                  style: Styles.textStyle3,
                                ),
                              ],
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: ideaController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              hintText: "Share Your Idea",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)))),
                        ),
                      ),
                      const Gap(5),
                      Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Post',
                            style: Styles.headLineStyle3,
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
