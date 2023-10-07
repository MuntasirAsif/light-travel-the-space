import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:get_space_ticket/Users_ui/view_all_ticket.dart';
import 'package:get_space_ticket/utils/ticket_view.dart';
import 'package:get_space_ticket/utils/app_styles.dart';

import 'buy_ticket_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String type;
  DateTime _lunchingDateTime = DateTime.now();
  DateTime _returningDateTime = DateTime.now();
  DatabaseReference ref = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
      'https://light-24555-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref("post");
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 300.0,
                    height: 70,
                    child: DefaultTextStyle(
                      style: const TextStyle(fontSize: 30, color: Colors.black87,fontWeight: FontWeight.bold),
                      child: AnimatedTextKit(
                        totalRepeatCount: 2,
                        animatedTexts: [
                          TyperAnimatedText('What are you Looking For?'),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                CustomRadioButton(
                  enableShape: true,
                  buttonLables: const [
                    'Planet',
                    'Satelite',
                    'Space Station',
                  ],
                  buttonValues: const [
                    'Planet',
                    'Satelite',
                    'Space Station',
                  ],
                  radioButtonValue: (value) {
                    type = value;
                  },
                  unSelectedColor: Colors.white70,
                  selectedColor: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(Icons.rocket_launch),
                          Text(
                            ' Launching Date',
                            style: Styles.headLineStyle2,
                          ),
                        ],
                      ),
                      const Gap(5),
                      CupertinoDateTextBox(
                        initialValue: _lunchingDateTime,
                        onDateChange: onLaunching,
                        hintText: 'Date',
                        hintColor: Colors.black12,
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(Icons.rocket_rounded),
                          Text(
                            ' Return Date',
                            style: Styles.headLineStyle2,
                          ),
                        ],
                      ),
                      const Gap(5),
                      CupertinoDateTextBox(
                        initialValue: _returningDateTime,
                        onDateChange: onReturn,
                        hintText: 'Date',
                        hintColor: Colors.black12,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewAllTicket()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      width: 350,
                      child: const Center(
                          child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      )),
                    ),
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upcoming Launches',
                            style: Styles.headLineStyle2,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewAllTicket()));
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
                  height: 200,
                  child: Expanded(
                    child: StreamBuilder(
                      stream: ref.onValue, builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else{
                        Map<dynamic, dynamic>? map = snapshot.data?.snapshot.value as dynamic;
                        List<dynamic>? list =[];
                        list.clear();
                        list =map?.values.toList();
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount : 3,
                            itemBuilder: (context, index){
                              return  SingleChildScrollView(
                                  child: InkWell(
                                    child: TicketView(
                                      photo: list?[index]['image'],
                                      formAdd: list?[index]['fromAdd'],
                                      toAdd: list?[index]['toAdd'],
                                      space: list?[index]['spaceName'],
                                      price: list?[index]['price'],
                                      launceDate:
                                      list?[index]['lunchingDate'],
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BuyTicketScreen(launchingID: list?[index]['lunchCode'])));
                                    },
                                  ));
                            });
                      }
                    },
                    ),
                  ),),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLaunching(DateTime lunchingDate) {
    setState(() {
      _lunchingDateTime = lunchingDate;
    });
  }

  void onReturn(DateTime returnDate) {
    setState(() {
      _returningDateTime = returnDate;
    });
  }
}
