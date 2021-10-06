import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bitcoins"),
      ),
      body: widget.child,
    );
  }
}
