import 'dart:convert';

enum InvestmentHorizon { shortTerm, midTerm, longTerm }
enum InvestorStatus { open, indifferent, notOpen }

class InvestorProfile {
  String id;
  String name;
  String contactNumber;
  String email;
  String location;
  List<InvestmentHorizon> preferredHorizons;
  InvestorStatus status;
  List<String> interests;
  DateTime registeredAt;

  InvestorProfile({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.location,
    required this.preferredHorizons,
    required this.status,
    required this.interests,
    required this.registeredAt,
  });

  /// ✅ Add empty constructor
  factory InvestorProfile.empty() {
    return InvestorProfile(
      id: '',
      name: '',
      contactNumber: '',
      email: '',
      location: '',
      preferredHorizons: [],
      status: InvestorStatus.open,
      interests: [],
      registeredAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'contactNumber': contactNumber,
        'email': email,
        'location': location,
        'preferredHorizons': preferredHorizons.map((e) => e.name).toList(),
        'status': status.name,
        'interests': interests,
        'registeredAt': registeredAt.toIso8601String(),
      };

  factory InvestorProfile.fromJson(Map<String, dynamic> json) => InvestorProfile(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        contactNumber: json['contactNumber'] ?? '',
        email: json['email'] ?? '',
        location: json['location'] ?? '',
        preferredHorizons: (json['preferredHorizons'] as List<dynamic>?)
                ?.map((e) =>
                    InvestmentHorizon.values.firstWhere((h) => h.name == e))
                .toList() ??
            [],
        status: InvestorStatus.values.firstWhere(
          (s) => s.name == json['status'],
          orElse: () => InvestorStatus.open,
        ),
        interests: List<String>.from(json['interests'] ?? []),
        registeredAt: DateTime.tryParse(json['registeredAt'] ?? '') ??
            DateTime.now(),
      );

  static List<InvestorProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List<dynamic>)
          .map<InvestorProfile>((e) => InvestorProfile.fromJson(e))
          .toList();

  static String encode(List<InvestorProfile> profiles) =>
      jsonEncode(profiles.map((e) => e.toJson()).toList());
}
