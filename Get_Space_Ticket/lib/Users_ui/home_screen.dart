import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/Users_ui/buy_ticket_screen.dart';
import 'package:get_space_ticket/Users_ui/planet_screen.dart';
import 'package:get_space_ticket/Users_ui/view_all_ticket.dart';
import 'package:get_space_ticket/about_us.dart';
import 'package:get_space_ticket/utils/planet_sat_view.dart';
import 'package:get_space_ticket/utils/ticket_view.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:get_space_ticket/utils/tracking_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  DatabaseReference ref = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("post");
  DatabaseReference ref2 = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("Planet");
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Gap(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning",
                                style: Styles.headLineStyle3,
                              ),
                              const Gap(10),
                              SizedBox(
                                width: 300.0,
                                height: 70,
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                  child: AnimatedTextKit(
                                    totalRepeatCount: 2,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          'Travels with Speed of Light'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/images/logo.jpg"))),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black54,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Now', style: Styles.textStyle2),
                              Text(
                                'Travelling',
                                style: Styles.textStyle2,
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Gap(5),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrackingScreen()));
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            'assets/images/MARS.jpg'),
                                      ),
                                    ),
                                    const Gap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrackingScreen()));
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TrackingScreen()));
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              'assets/images/earth.jpg'),
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrackingScreen()));
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            'assets/images/firststation.jpg'),
                                      ),
                                    ),
                                    const Gap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrackingScreen()));
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            'assets/images/MARS.jpg'),
                                      ),
                                    ),
                                    const Gap(10),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TrackingScreen()));
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            'assets/images/earth.jpg'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black54,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upcoming Launches',
                            style: Styles.headLineStyle2,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViewAllTicket()));
                              },
                              child: Text(
                                'View all',
                                style: TextStyle(
                                    color: Colors.brown.shade500,
                                    fontWeight: FontWeight.w400),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.25,
                  child: StreamBuilder(
                    stream: ref.onValue,
                    builder: (BuildContext context,
                        AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        Map<dynamic, dynamic>? map =
                            snapshot.data?.snapshot.value as dynamic;
                        List<dynamic>? list = [];
                        list.clear();
                        list = map?.values.toList();
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(3, (index) {
                              if (list != null && list.length > index) {
                                return InkWell(
                                  child: TicketView(
                                    photo: list[index]['image'] ??
                                        'N/A', // Use the null-aware operator
                                    formAdd: list[index]['fromAdd'] ?? 'N/A',
                                    toAdd: list[index]['toAdd'] ?? 'N/A',
                                    space: list[index]['spaceName'] ?? 'N/A',
                                    price: list[index]['price'] ?? 'N/A',
                                    launceDate:
                                        list[index]['launchingDate'] ?? 'N/A',
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BuyTicketScreen(
                                          launchingID: list?[index]
                                              ['lunchCode'],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox(); // Return an empty widget if data is null
                              }
                            }),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Planets and satellites',
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .50,
                  child: FirebaseAnimatedList(
                    scrollDirection: Axis.horizontal,
                    query: ref2,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlanetScreen(
                                      name: snapshot
                                          .child('item')
                                          .value
                                          .toString()),
                                ),
                              );
                            },
                            child: PlanetView(
                              photo:
                                  snapshot.child('image_url').value.toString(),
                              name: snapshot.child('name').value.toString(),
                              type: snapshot.child('type').value.toString(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Gap(10),
                Container(
                  height: height * 0.05,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Developed by : Team BrainForster (NITER)',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AboutUs()));
                          },
                            child: const Text(
                          'See Details',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
