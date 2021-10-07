import 'package:bitcoins/values/theme.dart';
import 'package:flutter/material.dart';


/*WIDGET CON LA PAGINA PADRE DE TODAS LAS DEMAS*/
class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.child, this.title = "Bitcoins"})
      : super(key: key);

  final Widget child;
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: primaryColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
              )
            ],
          ),
          widget.child
        ],
      ),
    );
  }
}
