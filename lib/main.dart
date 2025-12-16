import 'package:firstapp/pages/cal.dart';
import 'package:firstapp/pages/contact.dart';
import 'package:firstapp/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pattama Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          // 修复 dot-shorthands 为标准语法
          seedColor: const Color.fromARGB(255, 218, 19, 191),
        ),
      ),
      home: const MyHomePage(title: 'Calculate Change'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final tabs = const [
    // 添加 const 优化
    HomePage(),
    CalculatePage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: tabs[_currentIndex], // 修复格式
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          // 添加 const
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "Calculation"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page), label: "Contact"),
        ],
        onTap: (index) {
          setState(() {
            // print(index);
            _currentIndex = index;
          });
        },
      ),
    );
  }
}