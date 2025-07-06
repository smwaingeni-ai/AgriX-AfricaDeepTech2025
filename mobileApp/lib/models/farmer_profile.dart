import 'dart:convert';

class FarmerProfile {
  String id;
  String name;
  String phone;
  String region;
  String farmType;

  FarmerProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.region,
    required this.farmType,
  });

  factory FarmerProfile.empty() => FarmerProfile(
        id: '',
        name: '',
        phone: '',
        region: '',
        farmType: '',
      );

  factory FarmerProfile.fromJson(Map<String, dynamic> json) => FarmerProfile(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        region: json['region'] ?? '',
        farmType: json['farmType'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'region': region,
        'farmType': farmType,
      };

  static String encode(List<FarmerProfile> profiles) =>
      jsonEncode(profiles.map((e) => e.toJson()).toList());

  static List<FarmerProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((item) => FarmerProfile.fromJson(item))
          .toList();
}
