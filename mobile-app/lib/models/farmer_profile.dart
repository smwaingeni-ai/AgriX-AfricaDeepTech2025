class FarmerProfile {
  final String id;
  final String name;
  final String nationalId;
  final String location;
  final double farmSizeHectares;
  final bool govtAffiliated;
  final bool subsidised;

  FarmerProfile({
    required this.id,
    required this.name,
    required this.nationalId,
    required this.location,
    required this.farmSizeHectares,
    required this.govtAffiliated,
  }) : subsidised = govtAffiliated;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nationalId': nationalId,
    'location': location,
    'farmSizeHectares': farmSizeHectares,
    'govtAffiliated': govtAffiliated,
    'subsidised': subsidised,
  };

  static FarmerProfile fromJson(Map<String, dynamic> json) => FarmerProfile(
    id: json['id'],
    name: json['name'],
    nationalId: json['nationalId'],
    location: json['location'],
    farmSizeHectares: json['farmSizeHectares'],
    govtAffiliated: json['govtAffiliated'],
  );
}
