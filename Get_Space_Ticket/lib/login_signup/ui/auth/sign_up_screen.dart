import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/login_signup/ui/auth/company_signup_screen.dart';
import 'package:get_space_ticket/login_signup/ui/auth/user_signup_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Light',
                            textStyle: const TextStyle(
                                fontSize: 40.0,
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
                      'Travel With speed of Light',
                      style: TextStyle(fontSize: 8),
                    )
                  ],
                ),
              ],
            ),
            const Gap(50),
            const Column(
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  'As',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Gap(20),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            controller: tabController,
                            tabs: const [
                              Tab(text: 'User'),
                              Tab(text: 'Company')
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
                  UserSignUp(),
                  CompanySignUp()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
