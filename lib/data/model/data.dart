class Data {
  String base = "";
  String currency = "";
  String amount = "0.0";
  String date = "";

  Data({required this.base, required this.currency, required this.amount, this.date = ""});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      base: json['base'], currency: json['currency'], amount: json['amount']);

  Map<String, dynamic> toJson() =>
      {'base': base, 'currency': currency, 'amount': amount};
}
