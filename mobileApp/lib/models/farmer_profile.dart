class FarmerProfile {
  final String id;
  final String name;
  final String nationalId;
  final String location;
  final double farmSizeHectares;
  final bool govtAffiliated;
  final String qrImagePath;
  final double? latitude;
  final double? longitude;
  final String? locality;
  final String? district;

  FarmerProfile({
    required this.id,
    required this.name,
    required this.nationalId,
    required this.location,
    required this.farmSizeHectares,
    required this.govtAffiliated,
    required this.qrImagePath,
    this.latitude,
    this.longitude,
    this.locality,
    this.district,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nationalId': nationalId,
        'location': location,
        'farmSizeHectares': farmSizeHectares,
        'govtAffiliated': govtAffiliated,
        'qrImagePath': qrImagePath,
        'latitude': latitude,
        'longitude': longitude,
        'locality': locality,
        'district': district,
      };

  static FarmerProfile fromJson(Map<String, dynamic> json) => FarmerProfile(
        id: json['id'],
        name: json['name'],
        nationalId: json['nationalId'],
        location: json['location'],
        farmSizeHectares: (json['farmSizeHectares'] ?? 0).toDouble(),
        govtAffiliated: json['govtAffiliated'] ?? false,
        qrImagePath: json['qrImagePath'],
        latitude: (json['latitude'] ?? 0.0).toDouble(),
        longitude: (json['longitude'] ?? 0.0).toDouble(),
        locality: json['locality'],
        district: json['district'],
      );
}
