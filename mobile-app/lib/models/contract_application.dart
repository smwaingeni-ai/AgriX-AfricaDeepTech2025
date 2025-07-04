class ContractApplication {
  final String id;
  final String contractOfferId;
  final String farmerName;
  final String farmerId;
  final String location;
  final String phoneNumber;
  final String email;
  final String farmSize; // e.g., "2 hectares"
  final String experience; // e.g., "5 years poultry"
  final String motivation; // short reason for applying
  final DateTime appliedAt;
  final String status; // Pending, Approved, Rejected, In Progress

  ContractApplication({
    required this.id,
    required this.contractOfferId,
    required this.farmerName,
    required this.farmerId,
    required this.location,
    required this.phoneNumber,
    required this.email,
    required this.farmSize,
    required this.experience,
    required this.motivation,
    required this.appliedAt,
    this.status = 'Pending',
  });

  factory ContractApplication.fromJson(Map<String, dynamic> json) {
    return ContractApplication(
      id: json['id'],
      contractOfferId: json['contractOfferId'],
      farmerName: json['farmerName'],
      farmerId: json['farmerId'],
      location: json['location'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      farmSize: json['farmSize'],
      experience: json['experience'],
      motivation: json['motivation'],
      appliedAt: DateTime.parse(json['appliedAt']),
      status: json['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contractOfferId': contractOfferId,
      'farmerName': farmerName,
      'farmerId': farmerId,
      'location': location,
      'phoneNumber': phoneNumber,
      'email': email,
      'farmSize': farmSize,
      'experience': experience,
      'motivation': motivation,
      'appliedAt': appliedAt.toIso8601String(),
      'status': status,
    };
  }
}
