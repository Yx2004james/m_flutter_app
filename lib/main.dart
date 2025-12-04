import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tui shop',
      theme: ThemeData(
        fontFamily: 'maa',
      ),
      home: const MyHomePage(title: 'Pattama Shop'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var price = TextEditingController();
  var amount = TextEditingController();
  var change = TextEditingController();

  double _total = 0;
  double _change = 0;
  String _changeMessage = '';

  @override
  void dispose() {
    price.dispose();
    amount.dispose();
    change.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd8c6f1),   // ← 改成练习图的淡紫色
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: "maa"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 练习图大标题
              Text(
                " Change Calculate",
                style: TextStyle(
                  fontFamily: "maa",
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.lightBlue,
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(height: 20),

              Image.asset("assets/1.jpg", height: 100),
              SizedBox(height: 20),

              priceTextField(),
              amountTextField(),

              // 练习图按钮
              calculateButton(),

              showTotalText(),
              receiveMoneyTextField(),
              changeCalculateButton(),
              showChangeText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: price,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'price per item',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget amountTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: amount,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'amount of items',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget calculateButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 248, 246, 246),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        onPressed: () {
          if (price.text.isNotEmpty && amount.text.isNotEmpty) {
            double p = double.parse(price.text);
            double a = double.parse(amount.text);

            setState(() {
              _total = p * a;
            });
          }
        },
        child: Text(
          'Calculate Total',
          style: TextStyle(
            fontFamily: "maa",
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 72, 32, 75),
          ),
        ),
      ),
    );
  }

  Widget showTotalText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('total : $_total Baht'),
    );
  }

  Widget receiveMoneyTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: change,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'get money',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget changeCalculateButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (change.text.isNotEmpty) {
            double money = double.parse(change.text);

            setState(() {
              if (money < _total) {
                _change = 0;
                _changeMessage = 'Money is not enough.';
              } else {
                _change = money - _total;
                _changeMessage = '';
              }
            });
          }
        },
        child: const Text('Calculate Change'),
      ),
    );
  }

  Widget showChangeText() {
    final text = _changeMessage.isNotEmpty
        ? _changeMessage
        : 'Change : $_change Baht';

    return Padding(padding: const EdgeInsets.all(8.0), child: Text(text));
  }
}
