import 'package:flutter/material.dart';

/*WIDGET QUE MUESTRA EL TITULO DE LA LISTA DE LOS PRECIOS DE DOS SEMANAS*/
class TitleList extends StatelessWidget {
  const TitleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Prices",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            "Last two weeks",
            style: TextStyle(color: Color(0xFF70768E), fontSize: 14),
          )
        ],
      ),
    );
  }
}
