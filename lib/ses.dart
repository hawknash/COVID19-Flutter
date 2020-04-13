import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Sessions extends StatefulWidget {
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
        
      ),
    );
  }
}