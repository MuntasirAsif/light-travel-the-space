import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Team BrainForster'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body:  const Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 30,
              backgroundImage: AssetImage('assets/images/feroj (1).jpg'),
            ),
            title: Text('MD Feroj Miah'),
            subtitle: Text('Team Leader'),

          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 30,
              backgroundImage: AssetImage(
                  'assets/images/ashif (2).jpg'),
            ),
            title: Text('Muhammad Muntasir Mahamud Ashif'),
            subtitle: Text('Developer'),

          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 30,
              backgroundImage: AssetImage(
                  'assets/images/nova.jpg'),
            ),
            title: Text('Nisita Islam Nova'),
            subtitle: Text('Researcher'),

          ),
        ],
      ),

    );
  }
}
