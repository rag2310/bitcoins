import 'package:bitcoins/bloc/prices/prices_barrel.dart';
import 'package:bitcoins/ui/details/details_page.dart';
import 'package:bitcoins/ui/prices/widgets/title_list.dart';
import 'package:bitcoins/ui/prices/widgets/today_price.dart';
import 'package:bitcoins/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/*WIDGET PRINCIPAL DONDE SE MUESTRAN LOS PRECIOS DE DOS SEMANAS ATRAS Y DEL DIA DE HOY*/
class PricesPage extends StatefulWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  @override
  void initState() {
    /*INICIAMOS EL EVENTO PricesStarted*/
    context.read<PricesBloc>().add(const PricesStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricesBloc, PricesState>(
      builder: (context, state) {
        /*VALIDAMOS EL ESTADO PricesSuccess*/
        if (state is PricesSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TodayPrice(
                  base: state.response.data.base,
                  amount: state.response.data.amount,
                  currency: state.response.data.currency,
                ),
                const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                const TitleList(),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.response.listData.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = state.response.listData[index];
                        return PriceCard(
                          data: data,
                          onClick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      data: data,
                                    )));
                          },
                        );
                      }),
                )
              ],
            ),
          );
        }


        /*VALIDAMOS EL ESTADO PricesError*/
        if (state is PricesError) {
          return Error(msg: state.response.msgError);
        }


        /*VALIDAMOS EL ESTADO PricesNotInternet*/
        if (state is PricesNotInternet) {
          return const Error(msg: "Without Internet");
        }

        return const Loading();
      },
    );
  }
}
