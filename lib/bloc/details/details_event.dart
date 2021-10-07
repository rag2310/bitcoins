part of 'details_bloc.dart';

/*EVENTOS DE details_bloc.dart*/
abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class DetailsStarted extends DetailsEvent {
  const DetailsStarted({required this.date});

  final String date;
}

class _DetailsGetting extends DetailsEvent {
  const _DetailsGetting(this.response);

  final Response response;

  @override
  List<Object> get props => [response];
}
