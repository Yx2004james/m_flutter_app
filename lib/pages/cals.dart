import 'package:flutter/material.dart';

class CalPage extends StatefulWidget {
  const CalPage({super.key});

  @override
  State<CalPage> createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  final TextEditingController _price = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _money = TextEditingController();

  double _total = 0;
  double _change = 0;
  String _message = '';

  @override
  void dispose() {
    _price.dispose();
    _amount.dispose();
    _money.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Calculation')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Change Calculation',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Image.asset('assets/1.jpg', height: 200),
              const SizedBox(height: 16),
              _buildTextField(_price, 'Price per item'),
              _buildTextField(_amount, 'Amount'),
              ElevatedButton(
                onPressed: _calculateTotal,
                child: const Text('Calculate Total'),
              ),
              Text('Total : $_total Baht'),
              _buildTextField(_money, 'Get money'),
              ElevatedButton(
                onPressed: _calculateChange,
                child: const Text('Calculate Change'),
              ),
              Text(
                _message.isNotEmpty ? _message : 'Change : $_change Baht',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }

  void _calculateTotal() {
    if (_price.text.isNotEmpty && _amount.text.isNotEmpty) {
      setState(() {
        _total = double.parse(_price.text) * double.parse(_amount.text);
      });
    }
  }

  void _calculateChange() {
    if (_money.text.isNotEmpty) {
      double m = double.parse(_money.text);
      setState(() {
        if (m < _total) {
          _message = 'Money is not enough';
          _change = 0;
        } else {
          _change = m - _total;
          _message = '';
        }
      });
    }
  }
}