import 'package:bitcoins/bloc/prices/prices_bloc.dart';
import 'package:bitcoins/ui/prices/widgets/price_card.dart';
import 'package:bitcoins/ui/prices/widgets/title_list.dart';
import 'package:bitcoins/ui/prices/widgets/today_price.dart';
import 'package:bitcoins/ui/widgets/error.dart';
import 'package:bitcoins/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TodayPrice(
                    base: state.response.data.base,
                    amount: state.response.data.amount),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const TitleList(),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.response.listData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PriceCard(
                          data: state.response.listData[index],
                        );
                      }),
                )
              ],
            ),
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
