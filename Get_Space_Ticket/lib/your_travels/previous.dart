import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/app_styles.dart';
import '../utils/book_ticket.dart';
class PreviousTravel extends StatefulWidget {
  const PreviousTravel({Key? key}) : super(key: key);

  @override
  State<PreviousTravel> createState() => _PreviousTravelState();
}

class _PreviousTravelState extends State<PreviousTravel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: ListView(
          children: const [
          ],
        ),
      ),
    );
  }
}
