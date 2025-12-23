import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ PDF 要求：Different image (from internet)
            Image.network(
              'https://cdn.pixabay.com/photo/2017/01/20/00/30/maldives-1993704_640.jpg',
              width: 220,
            ),
            const SizedBox(height: 20),

            // ✅ Information
            const Text(
              'Product Detail',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              'This is the detail page',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            // ✅ PDF 要求：Back to previous page
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}