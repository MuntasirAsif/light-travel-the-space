import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_space_ticket/utils/app_layout.dart';

class PlanetView extends StatelessWidget {
  final String photo;
  final String name;
  final String type;
  const PlanetView(
      {Key? key, required this.photo, required this.name, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Expanded(
      child: SizedBox(
        width: size.width * .6,
        height: 400,
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
                width: 300,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      width: 300,
                      height: 380,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 250,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(photo),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 10, 
                            ),
                            child: Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Gap(3),
                                    Row(
                                      children: [
                                        const Text(
                                          'Type: ',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          type,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    const Text(
                                      'Learn More...',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
