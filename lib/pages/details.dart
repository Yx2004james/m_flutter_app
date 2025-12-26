import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String v1;
  final String v2;
  final String v3;
  final String v4;

  const DetailPage(this.v1, this.v2, this.v3, this.v4, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String v1, v2, v3, v4;

  @override
  void initState() {
    super.initState();
    v1 = widget.v1;
    v2 = widget.v2;
    v3 = widget.v3;
    v4 = widget.v4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(v1),
            Text(v2),
            Image.network(
              v3,
              height: 220,
              fit: BoxFit.cover,
            ),
            Text(v4),
          ],
        ),
      ),
    );
  }
}