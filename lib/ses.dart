import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Sessions2 extends StatefulWidget {
  @override
  _Sessions2State createState() => _Sessions2State();
}

class _Sessions2State extends State<Sessions2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
        
      ),
    );
  }
}