import 'package:bitcoins/bloc/prices/prices.dart';
import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/utils/connection_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'prices_event.dart';
part 'prices_state.dart';

class PricesBloc extends Bloc<PricesEvent, PricesState> {
  PricesBloc(Prices prices) : super(PricesInitial()) {
    on<PricesStarted>((event, emit) async {
      bool internet = await ConnectionStatus.internal().checkConnection();

      if (internet) {
        await emit.onEach<Response>(
          prices.get(),
          onData: (response) => add(_PricesGetting(response)),
        );
      } else {
        emit(const PricesNotInternet());
      }
    });
    on<_PricesGetting>((event, emit) {
      if (!event.response.error) {
        emit(PricesSuccess(event.response as Success));
      } else {
        emit(PricesError(event.response as NotSuccess));
      }
    });
  }
}
