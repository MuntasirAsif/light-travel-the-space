import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/login_signup/widget/round_button.dart';
import 'package:get_space_ticket/utils/app_styles.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const Gap(30),
              Text('Live Tracking',style: Styles.headLineStyle,),
              const Gap(30),
               Row(
                children: [
                  const Gap(32),
                  const CircleAvatar(
                    backgroundColor: Colors.black54,
                  ),
                  const Gap(50),
                  Text('Landed Successfully',style: Styles.headLineStyle2,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(50),
                   Container(
                     height: 90,
                     width: 2,
                     color: Colors.black,
                   ),
                  const Gap(70),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Coming Back',style: Styles.headLineStyle2,),
                      Text('Tour is complete,\nthey are ready to landing',style: Styles.textStyle2,),
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  Gap(32),
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(50),
                  Container(
                    height: 90,
                    width: 2,
                    color: Colors.black,
                  ),
                  const Gap(70),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Out of Spaceship',style: Styles.headLineStyle2,),
                      Text('All Tourist are out of Spaceship,\nthey are walking on planet',style: Styles.textStyle2,),
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  Gap(32),
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(50),
                  Container(
                    height: 90,
                    width: 2,
                    color: Colors.black,
                  ),
                  const Gap(70),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Earth orbit',style: Styles.headLineStyle2,),
                      Text('Take off successfully,\nnow they crossing Earth orbit',style: Styles.textStyle2,),
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  Gap(32),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(50),
                  Container(
                    height: 100,
                    width: 2,
                    color: Colors.black,
                  ),
                  const Gap(70),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Taking off from Earth',style: Styles.headLineStyle2,),
                      Text('Everything is okay,\nthey are ready to Take off',style: Styles.textStyle2,),
                    ],
                  ),
                ],
              ),
              const Row(
                children: [
                  Gap(32),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                  )
                ],
              ),
              const Gap(30),
              RoundButton(title: 'See Live Photos', ontap: (){

              })
            ],
          ),
        ),
      ),
    );
  }
}
