import 'dart:convert';

class MarketItem {
  final String id;
  final String title;
  final String description;
  final String category; // e.g. Crop, Livestock, Land, Product
  final String listingType; // Sale, Lease, Barter, Request
  final String location;
  final double? price;
  final List<String> imagePaths;
  final List<String> contactMethods; // Phone, SMS, WhatsApp, etc.
  final List<String> paymentOptions; // Cash, Loan, QR, Mobile Money
  final bool isAvailable;
  final bool isInvestmentOpen;
  final String investmentStatus; // Open, Indifferent, Not Open
  final String duration; // Short (1–2 yrs), Mid (3–5 yrs), Long (>6 yrs)
  final String ownerName;
  final String ownerContact;
  final DateTime postedAt;

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
    required this.postedAt,
  });

  /// Creates an empty MarketItem
  factory MarketItem.empty() => MarketItem(
        id: '',
        title: '',
        description: '',
        category: '',
        listingType: '',
        location: '',
        price: 0.0,
        imagePaths: [],
        contactMethods: [],
        paymentOptions: [],
        isAvailable: true,
        isInvestmentOpen: false,
        investmentStatus: 'Open',
        duration: 'Short',
        ownerName: '',
        ownerContact: '',
        postedAt: DateTime.now(),
      );

  /// Converts a MarketItem to JSON
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
        'postedAt': postedAt.toIso8601String(),
      };

  /// Creates a MarketItem from JSON
  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        listingType: json['listingType'] ?? '',
        location: json['location'] ?? '',
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
        postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
      );

  /// Encode list of MarketItems
  static String encodeList(List<MarketItem> items) =>
      json.encode(items.map((item) => item.toJson()).toList());

  /// Decode list of MarketItems
  static List<MarketItem> decodeList(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map((e) => MarketItem.fromJson(e))
          .toList();
}
