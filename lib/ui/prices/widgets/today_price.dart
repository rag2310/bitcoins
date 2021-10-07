import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodayPrice extends StatefulWidget {
  const TodayPrice(
      {Key? key,
      required this.base,
      required this.amount,
      required this.currency})
      : super(key: key);

  final String base;
  final String amount;
  final String currency;

  @override
  _TodayPriceState createState() => _TodayPriceState();
}

class _TodayPriceState extends State<TodayPrice> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Today's price",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: FaIcon(
                            FontAwesomeIcons.bitcoin,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        Text(
                          "${widget.base} to ${widget.currency}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "\$ ${widget.amount}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
