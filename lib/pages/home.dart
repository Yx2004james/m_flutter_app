import 'package:firstapp/pages/detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget MyBox(
    BuildContext context,
    String title,
    String subtitle,
    String imageUrl,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailPage(),
                ),
              );
            },
            child: const Text(
              'read more',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Knowledge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            MyBox(
              context,
              'What is a computer?',
              'Computer is a things to calculate and do any other works',
              'https://cdn.pixabay.com/photo/2016/03/26/13/09/workspace-1280538_960_720.jpg',
            ),
            const SizedBox(height: 20),
            MyBox(
              context,
              'What is Flutter?',
              'Flutter is a tool to create a mobile application',
              'https://cdn.pixabay.com/photo/2023/11/18/18/20/christmas-8396941_1280.png',
            ),
            const SizedBox(height: 20),
            MyBox(
              context,
              'What is Dart?',
              'Dart is the language used in Flutter',
              'https://cdn.pixabay.com/photo/2024/11/05/11/30/bridge-9175733_1280.jpg',
            ),
          ],
        ),
      ),
    );
  }
}