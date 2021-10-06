import 'package:bitcoins/data/model/data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceCard extends StatefulWidget {
  const PriceCard({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  _PriceCardState createState() => _PriceCardState();
}

class _PriceCardState extends State<PriceCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.bitcoin,
                      size: 48,
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(widget.data.base),
                    ),
                    Text(
                      widget.data.date,
                      style: const TextStyle(
                          color: Color(0xFF70768E), fontSize: 12),
                    )
                  ],
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$ ${widget.data.amount}",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
