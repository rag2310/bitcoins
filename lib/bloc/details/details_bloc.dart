import 'package:bitcoins/bloc/details/details.dart';
import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/utils/connection_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(Details details) : super(DetailsInitial()) {
    /*EVENTO DE INICIO*/
    on<DetailsStarted>((event, emit) async {
      bool internet = await ConnectionStatus.internal().checkConnection();
      emit(DetailsInitial());
      if (internet) {
        await emit.onEach<Response>(details.get(event.date),
            onData: (response) => add(_DetailsGetting(response)));
      } else {}
    });

    /*EVENTO DE PROCESAMIENTO DE DATOS*/
    on<_DetailsGetting>((event, emit) {
      if (!event.response.error) {
        emit(DetailsSuccess(event.response as Success));
      } else {
        emit(DetailsError(event.response as NotSuccess));
      }
    });
  }
}
