import 'dart:convert';

class MarketItem {
  final String id;
  final String title;
  final String description;
  final String category; // e.g., Land, Livestock, Crops, Equipment
  final String listingType; // Sale, Lease, Barter, Request
  final String location;
  final double? price;
  final List<String> imagePaths;
  final List<String> contactMethods; // e.g., Phone, SMS, WhatsApp
  final List<String> paymentOptions; // e.g., Cash, Loan, QR Code, Mobile Money
  final bool isAvailable;
  final bool isInvestmentOpen;
  final String investmentStatus; // Open, Indifferent, Not Open
  final String duration; // Short (1–2 yrs), Mid (3–5 yrs), Long (>6 yrs)
  final String ownerName;
  final String ownerContact;

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.listingType,
    required this.location,
    this.price,
    required this.imagePaths,
    required this.contactMethods,
    required this.paymentOptions,
    required this.isAvailable,
    required this.isInvestmentOpen,
    required this.investmentStatus,
    required this.duration,
    required this.ownerName,
    required this.ownerContact,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'listingType': listingType,
        'location': location,
        'price': price,
        'imagePaths': imagePaths,
        'contactMethods': contactMethods,
        'paymentOptions': paymentOptions,
        'isAvailable': isAvailable,
        'isInvestmentOpen': isInvestmentOpen,
        'investmentStatus': investmentStatus,
        'duration': duration,
        'ownerName': ownerName,
        'ownerContact': ownerContact,
      };

  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        listingType: json['listingType'],
        location: json['location'],
        price: (json['price'] as num?)?.toDouble(),
        imagePaths: List<String>.from(json['imagePaths'] ?? []),
        contactMethods: List<String>.from(json['contactMethods'] ?? []),
        paymentOptions: List<String>.from(json['paymentOptions'] ?? []),
        isAvailable: json['isAvailable'] ?? true,
        isInvestmentOpen: json['isInvestmentOpen'] ?? false,
        investmentStatus: json['investmentStatus'] ?? 'Open',
        duration: json['duration'] ?? 'Short',
        ownerName: json['ownerName'] ?? '',
        ownerContact: json['ownerContact'] ?? '',
      );

  static String encodeList(List<MarketItem> items) =>
      json.encode(items.map((i) => i.toJson()).toList());

  static List<MarketItem> decodeList(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map((e) => MarketItem.fromJson(e))
          .toList();
}
