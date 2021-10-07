import 'package:bitcoins/bloc/prices/prices.dart';
import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/utils/connection_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'prices_event.dart';

part 'prices_state.dart';

/*MANEJO DE EVENTOS DEL BLOC Prices.dart*/
class PricesBloc extends Bloc<PricesEvent, PricesState> {
  PricesBloc(Prices prices) : super(PricesInitial()) {

    /*EVENTO DE INICIO*/
    on<PricesStarted>((event, emit) async {
      bool internet = await ConnectionStatus.internal().checkConnection();

      if (internet) {
        await emit.onEach<Response>(
          prices.get(),
          onData: (response) => add(_PricesGetting(response)),
        );

        await emit.onEach<int>(prices.refresh(),
            onData: (refresh) => {add(const _PricesRefresh())});
      } else {
        emit(const PricesNotInternet());
      }
    });

    /*EVENTO DE PROCESAMIENTO DE DATOS*/
    on<_PricesGetting>((event, emit) {
      if (!event.response.error) {
        emit(PricesSuccess(event.response as Success));
      }
    });

    /*EVENTO DE ACTUALIZACION CADA 60 SEG*/
    on<_PricesRefresh>((event, emit) async {
      await emit.onEach<Response>(
        prices.get(),
        onData: (response) {
          add(_PricesGetting(response));
        },
      );
    });

    /*EVENTO DE PROCESAMIENTO DE DATOS ACTUALIZADOS*/
    /*on<_PricesUpdate>((event, emit) {
      if (!event.response.error) {
        emit(PricesSuccess(event.response as Success));
      } else {
        emit(PricesError(event.response as NotSuccess));
      }
    });*/
  }
}
