part of 'details_bloc.dart';

/*ESTADOS DE details_bloc.dart*/
abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsSuccess extends DetailsState {
  const DetailsSuccess(this.response);

  final Success response;

  @override
  List<Object> get props => [response];
}

class DetailsError extends DetailsState {
  const DetailsError(this.response);

  final NotSuccess response;

  @override
  List<Object> get props => [response];
}

class DetailsNotInternet extends DetailsState {
  const DetailsNotInternet();
}
