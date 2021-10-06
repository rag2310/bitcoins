import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text("Loading.."),
          )
        ],
      ),
    );
  }
}
