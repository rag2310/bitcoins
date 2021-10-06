import 'package:bitcoins/bloc/prices/prices_bloc.dart';
import 'package:bitcoins/ui/widgets/error.dart';
import 'package:bitcoins/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  @override
  void initState() {
    context.read<PricesBloc>().add(const PricesStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricesBloc, PricesState>(
      builder: (context, state) {
        if (state is PricesSuccess) {
          return Column(
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                title: const Text("Today"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                            child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: FaIcon(FontAwesomeIcons.bitcoin),
                            ),
                            Text(state.response.data.base)
                          ],
                        )),
                        Flexible(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text("\$${state.response.data.amount}")],
                        ))
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        }

        if (state is PricesError) {
          return Error(msg: state.response.msgError);
        }

        return const Loading();
      },
    );
  }
}
