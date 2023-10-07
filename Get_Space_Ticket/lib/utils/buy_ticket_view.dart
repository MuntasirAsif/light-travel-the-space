import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';

class BuyTicket extends StatelessWidget {
  final String service;
  final String space;
  final String formAd;
  final String toAd;
  final String name;
  final String occupation;
  final int money;
  final String bookingCode;
  final String lunchCode;
  const BuyTicket(
      {Key? key,
      required this.name,
      required this.money,
      required this.bookingCode,
      required this.toAd,
      required this.formAd,
      required this.lunchCode,
      required this.occupation,
      required this.space,
      required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      height: 700,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        children: [
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [const Text('From'), const Gap(5), Text(formAd)],
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
                children: [Text('To'), const Gap(5), Text(toAd)],
              ),
            ],
          ),
          const Divider(
            thickness: 2,
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  const Text('Name')
                ],
              ),
              Column(
                children: [
                  Text(
                    "\$$money",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  const Text('Price')
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '1 May',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Gap(5),
                  Text('Launching Date')
                ],
              ),
              Column(
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
                    '20 May',
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
                    space,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  const Text('Space')
                ],
              ),
              Column(
                children: [
                  Text(
                    lunchCode,
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
          const Gap(30),
          Center(
            child: Text(
              'Facilities & Services',
              style: Styles.headLineStyle2,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.black87,
          ),
          const Gap(10),
          Text(
            service,
            style: Styles.textStyle,
          ),
          const Gap(100),
        ],
      ),
    );
  }
}
