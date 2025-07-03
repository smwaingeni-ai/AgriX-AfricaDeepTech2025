class MarketItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String location;
  final double price;
  final String type; // Sale, Lease, Barter
  final List<String> photos;
  final List<String> paymentOptions;
  final String contact;

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.price,
    required this.type,
    required this.photos,
    required this.paymentOptions,
    required this.contact,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'location': location,
    'price': price,
    'type': type,
    'photos': photos,
    'paymentOptions': paymentOptions,
    'contact': contact,
  };

  static MarketItem fromJson(Map<String, dynamic> json) => MarketItem(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    category: json['category'],
    location: json['location'],
    price: json['price'],
    type: json['type'],
    photos: List<String>.from(json['photos']),
    paymentOptions: List<String>.from(json['paymentOptions']),
    contact: json['contact'],
  );
}