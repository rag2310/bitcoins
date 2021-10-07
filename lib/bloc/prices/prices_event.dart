part of 'prices_bloc.dart';

/*EVENTOS DE prices_bloc.dart*/
abstract class PricesEvent extends Equatable {
  const PricesEvent();

  @override
  List<Object> get props => [];
}

class PricesStarted extends PricesEvent {
  const PricesStarted();
}

class _PricesGetting extends PricesEvent {
  const _PricesGetting(this.response);

  final Response response;

  @override
  List<Object> get props => [response];
}

/*class _PricesUpdate extends PricesEvent {
  const _PricesUpdate(this.response);

  final Response response;

  @override
  List<Object> get props => [response];
}*/

class _PricesRefresh extends PricesEvent {
  const _PricesRefresh();
}
