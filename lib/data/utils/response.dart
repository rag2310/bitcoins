import 'package:bitcoins/data/model/data.dart';

abstract class Response {
  bool error;
  String msgError;

  Response({this.error = false, this.msgError = ""});
}

class Success extends Response {
  late Data data;

  Success({required this.data});
}

class NotSuccess extends Response {
  String newError = "";

  NotSuccess({required this.newError}) : super(error: true, msgError: newError);
}
