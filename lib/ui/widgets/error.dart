import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  const Error({Key? key, required this.msg}) : super(key: key);

  final String msg;

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(widget.msg),
          )
        ],
      ),
    );
  }
}
