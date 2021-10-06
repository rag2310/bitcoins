import 'package:bitcoins/ui/main_page.dart';
import 'package:bitcoins/ui/prices/prices_page.dart';
import 'package:bitcoins/values/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/prices/prices.dart';
import 'bloc/prices/prices_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bitcoins',
      theme: ThemeData(primarySwatch: primaryColor),
      home: BlocProvider(
          create: (_) => PricesBloc(Prices()),
          child: const MainPage(
            child: PricesPage(),
          )),
    );
  }
}
