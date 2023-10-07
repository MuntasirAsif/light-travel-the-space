import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatelessWidget {
  final double status;
  Dashboard({Key? key, required this.status, }) : super(key: key);
    final dataMap = <String, double>{
      "Status: Good": 85,
    };

  final colorList = <Color>[
    Colors.green.shade400,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.black54.withOpacity(0.15),
                colorList: colorList,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                totalValue: 100,
              ),
            ),
            const Gap(30),
            const Text(
              'Your Age: 20',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            const Text(
              'Wight: 70 Kg',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            const Text(
              'Physcial Condition: Good',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            const Text(
              'Medical Repot: Perfect',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(20),
            const Center(
              child: Text(
                'You Can Travel 😊',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
