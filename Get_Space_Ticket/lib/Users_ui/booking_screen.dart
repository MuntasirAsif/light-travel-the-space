import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:get_space_ticket/your_travels/previous.dart';
import 'package:get_space_ticket/your_travels/upcoming.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              SizedBox(
                width: 300.0,
                height: 50,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                    totalRepeatCount: 2,
                    animatedTexts: [
                      TyperAnimatedText('Your Travels'),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black87,
                                width: 5,
                              ),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              controller: tabController,
                              tabs: const [
                                Tab(text: 'Upcoming'),
                                Tab(text: 'Previous')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    UpcomingTravel(),
                    PreviousTravel()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
