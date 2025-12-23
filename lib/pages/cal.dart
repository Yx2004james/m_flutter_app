import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  //variable
  var price = TextEditingController();
  var amount = TextEditingController();
  var change = TextEditingController();
  double _total = 0;
  double _change = 0;

  @override
  Widget build(BuildContext context) {
    //return scaffold: appbar and body
    return Material(
      child: ListView(
        children: [
          Text(
            "Change Calculation",
            style: TextStyle(
                fontFamily: "maa",
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple,
                backgroundColor: Colors.blue),
          ),
          Image.asset(
            "assets/1.jpg",
            height: 240,
          ),
          Image.network(
            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: priceTextField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: amountTextField(),
          ),
          SizedBox(height: 8),
          calculateButton(),
          showTotalText(),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: receiveMoneyTextField(),
          ),
          SizedBox(height: 8),
          changeCalculateButton(),
          showChangeText(),
        ],
      ),
    );
  }

//custom widget
  Widget priceTextField() {
    return TextField(
      controller: price,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "price per item",
      ),
      keyboardType: TextInputType.numberWithOptions(),
    );
  }

  Widget amountTextField() {
    return TextField(
      controller: amount,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "amount of item",
      ),
      keyboardType: TextInputType.numberWithOptions(),
    );
  }

  Widget calculateButton() {
    return ElevatedButton(
        onPressed: () {
          if (price.text.isNotEmpty && amount.text.isNotEmpty) {
            setState(() {
              _total = double.parse(price.text) * double.parse(amount.text);
            });
          }
        },
        child: Text("Calculate Total"));
  }

  Widget showTotalText() {
    return Text("Total: $_total Bath");
  }

  Widget receiveMoneyTextField() {
    return TextField(
      controller: change,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "get money",
      ),
      keyboardType: TextInputType.numberWithOptions(),
    );
  }

  Widget changeCalculateButton() {
    return ElevatedButton(
        onPressed: () {
          if (price.text.isNotEmpty && amount.text.isNotEmpty) {
            setState(() {
              _change = double.parse(change.text) - _total;
            });
          }
        },
        child: Text("Calculate Change"));
  }

  Widget showChangeText() {
    return Text("Change: $_change:Baht");
  }
}