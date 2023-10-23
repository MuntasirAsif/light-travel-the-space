import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_styles.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatelessWidget {
  final double status;
  final String age;
  final String wight;
  final String height;
  Dashboard({Key? key, required this.status, required this.age, required this.wight, required this.height, }) : super(key: key);
  final colorList = <Color>[
    Colors.green.shade400,
  ];
  @override
  Widget build(BuildContext context) {
    String sign;
    if(status>90){
      sign = 'Perfect';
    }else if(status>80){
      sign = 'Good';
    }else if(status>70){
      sign = 'Not bad';
    }else{
      sign = 'Bad';
    }
    final dataMap = <String, double>{
      "Status: $sign": status,
    };
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
            Text(
              'Your Age: $age',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            Text(
              'Wight: $wight Kg',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            const Text(
              'Physcial Condition: N/A',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(5),
            const Text(
              'Medical Repot: N/A',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
