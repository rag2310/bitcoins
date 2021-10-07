part of 'prices_bloc.dart';

/*ESTADOS DE prices_bloc.dart*/
abstract class PricesState extends Equatable {
  const PricesState();

  @override
  List<Object> get props => [];
}

class PricesInitial extends PricesState {}

class PricesSuccess extends PricesState {
  const PricesSuccess(this.response);

  final Success response;

  @override
  List<Object> get props => [response];
}

class PricesError extends PricesState {
  const PricesError(this.response);

  final NotSuccess response;

  @override
  List<Object> get props => [response];
}

class PricesNotInternet extends PricesState {
  const PricesNotInternet();
}
