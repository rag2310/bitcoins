import 'package:bitcoins/bloc/details/details_barrel.dart';
import 'package:bitcoins/data/model/data.dart';
import 'package:bitcoins/ui/main_page.dart';
import 'package:bitcoins/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    context.read<DetailsBloc>().add(DetailsStarted(date: widget.data.date));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainPage(
      title: "Detail",
      child: BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
        if (state is DetailsSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Price of the day of ${widget.data.date}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Currency",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Of the day",
                        style:
                            TextStyle(color: Color(0xFF70768E), fontSize: 14),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.response.listData.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = state.response.listData[index];
                        return PriceCard(
                          data: data,
                          onClick: () {},
                        );
                      }),
                )
              ],
            ),
          );
        }
        if (state is DetailsError) {
          return Error(msg: state.response.msgError);
        }

        if (state is DetailsInitial) {
          return const Loading();
        }

        return const Loading();
      }),
    );
  }
}
