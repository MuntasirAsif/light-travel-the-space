import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

class TicketView extends StatelessWidget {
  final String photo;
  final String formAdd;
  final String toAdd;
  final String space;
  final String price;
  final String launceDate;

  const TicketView(
      {Key? key,
        required this.photo,
        required this.formAdd,
        required this.toAdd,
        required this.space,
        required this.price,
        required this.launceDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width*0.9,
      height: height*0.26,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: height*.08,
                        width: width*0.84,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(photo),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: height*.02,
              width: width*0.84,
              color: Colors.black87,
              child: Row(
                children: [
                  const SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                  ),
                  Expanded(child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            20,
                                (index) => const SizedBox(
                              width: 5,
                              height: 1,
                              child: DecoratedBox(
                                decoration:
                                BoxDecoration(color: Colors.white),
                              ),
                            )),
                      );
                    },
                  )),
                  const SizedBox(
                    height: 20,
                    width: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: height*.12,
              width: width*0.84,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From: $formAdd',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const Text(
                                'Space: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                space,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.rocket_launch,
                                color: Colors.white,
                              ),
                              Text(
                                '  Date',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Gap(2),
                          Text(
                            launceDate,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'To: $toAdd',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Gap(5),
                          const Text(
                            '7 Days',
                            style: TextStyle(color: Colors.white),
                          ),
                          const Gap(2),
                        ],
                      ),
                    ],
                  ),
                  Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '$price USD',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
