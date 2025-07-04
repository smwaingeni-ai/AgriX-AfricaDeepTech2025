import 'dart:convert';

class InvestmentOffer {
  final String id;
  final String listingId; // Link to MarketItem ID
  final String investorId; // Link to InvestorProfile ID
  final double amount;
  final String currency;
  final int durationMonths; // Investment duration in months
  final String message; // Optional message from investor
  final DateTime offerDate;
  final bool isAccepted;

  InvestmentOffer({
    required this.id,
    required this.listingId,
    required this.investorId,
    required this.amount,
    required this.currency,
    required this.durationMonths,
    required this.message,
    required this.offerDate,
    this.isAccepted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'listingId': listingId,
        'investorId': investorId,
        'amount': amount,
        'currency': currency,
        'durationMonths': durationMonths,
        'message': message,
        'offerDate': offerDate.toIso8601String(),
        'isAccepted': isAccepted,
      };

  factory InvestmentOffer.fromJson(Map<String, dynamic> json) => InvestmentOffer(
        id: json['id'],
        listingId: json['listingId'],
        investorId: json['investorId'],
        amount: json['amount'],
        currency: json['currency'],
        durationMonths: json['durationMonths'],
        message: json['message'],
        offerDate: DateTime.parse(json['offerDate']),
        isAccepted: json['isAccepted'],
      );

  static List<InvestmentOffer> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List<dynamic>)
          .map<InvestmentOffer>((e) => InvestmentOffer.fromJson(e))
          .toList();

  static String encode(List<InvestmentOffer> offers) =>
      jsonEncode(offers.map((e) => e.toJson()).toList());
}
