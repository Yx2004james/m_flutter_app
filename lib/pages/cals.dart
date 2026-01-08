import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CalPage extends StatefulWidget {
  const CalPage({super.key});

  @override
  State<CalPage> createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  // ====== 原本的计算器 ======
  final TextEditingController _price = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _money = TextEditingController();

  double _total = 0;
  double _change = 0;
  String _message = '';

  // ====== PDF: JS Integration ======
  late final WebViewController _controller;
  String _totalFromJS = ''; // e.g. "$120"
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    // ✅ PDF Workshop: addJavaScriptChannel('FlutterChannel', onMessageReceived: ...)
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          setState(() {
            _totalFromJS = message.message; // "$120"
          });
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => _progress = p),
          onPageStarted: (_) => setState(() => _progress = 0),
          onPageFinished: (_) => setState(() => _progress = 100),
        ),
      )
    // ✅ Step1: load challenge_webview.html
      ..loadFlutterAsset('assets/challenge_webview.html');
  }

  @override
  void dispose() {
    _price.dispose();
    _amount.dispose();
    _money.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator + WebView JS'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calculate), text: 'Calculator'),
              Tab(icon: Icon(Icons.javascript), text: 'JS Challenge'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCalculatorTab(),
            _buildJsChallengeTab(),
          ],
        ),
      ),
    );
  }

  // ========== Tab 1：你的计算器 ==========
  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Change Calculation',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
            Text(_message.isNotEmpty ? _message : 'Change : $_change Baht'),
          ],
        ),
      ),
    );
  }

  // ========== Tab 2：严格按 PDF 的 JS Integration ==========
  Widget _buildJsChallengeTab() {
    return Column(
      children: [
        if (_progress < 100) LinearProgressIndicator(value: _progress / 100),

        Expanded(
          child: WebViewWidget(controller: _controller),
        ),

        const Divider(height: 1),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ Step2: show total received from JS (Flutter side)
              Text(
                'Received from JS: ${_totalFromJS.isEmpty ? "-" : _totalFromJS}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              // ✅ Step3: send total+100 back to JS by calling updateTotalFromFlutter
              ElevatedButton(
                onPressed: _totalFromJS.isEmpty ? null : _sendPlus100ToJS,
                child: const Text('Send +100 total from Flutter to JS'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _sendPlus100ToJS() async {
    // _totalFromJS like "$120" => extract number
    final raw = _totalFromJS.replaceAll(RegExp(r'[^0-9.]'), '');
    final numValue = double.tryParse(raw);
    if (numValue == null) return;

    final newTotal = (numValue + 100).toInt(); // 按 PDF: total + 100
    // ✅ PDF Workshop: runJavaScript / runJavaScriptReturningResult
    await _controller.runJavaScript("updateTotalFromFlutter($newTotal);");
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
      final m = double.parse(_money.text);
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