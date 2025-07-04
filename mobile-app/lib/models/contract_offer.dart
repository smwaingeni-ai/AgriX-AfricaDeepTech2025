import 'package:flutter/foundation.dart';

class ContractOffer {
  final String id;
  final String title;
  final String description;
  final String category; // e.g., "Poultry", "Tomatoes", "Maize", "Goats"
  final String sponsorName;
  final String location;
  final double fundingAmount;
  final String duration; // e.g., "3 months", "1 year"
  final String requirements; // farmer eligibility or conditions
  final String paymentTerms; // e.g., profit share, fixed return
  final String contactPhone;
  final String contactEmail;
  final DateTime createdAt;
  final bool isVerified;
  final String status; // Open, Closed, Completed

  ContractOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.sponsorName,
    required this.location,
    required this.fundingAmount,
    required this.duration,
    required this.requirements,
    required this.paymentTerms,
    required this.contactPhone,
    required this.contactEmail,
    required this.createdAt,
    this.isVerified = false,
    this.status = "Open",
  });

  factory ContractOffer.fromJson(Map<String, dynamic> json) {
    return ContractOffer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      sponsorName: json['sponsorName'],
      location: json['location'],
      fundingAmount: (json['fundingAmount'] ?? 0).toDouble(),
      duration: json['duration'],
      requirements: json['requirements'],
      paymentTerms: json['paymentTerms'],
      contactPhone: json['contactPhone'],
      contactEmail: json['contactEmail'],
      createdAt: DateTime.parse(json['createdAt']),
      isVerified: json['isVerified'] ?? false,
      status: json['status'] ?? "Open",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'sponsorName': sponsorName,
      'location': location,
      'fundingAmount': fundingAmount,
      'duration': duration,
      'requirements': requirements,
      'paymentTerms': paymentTerms,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'createdAt': createdAt.toIso8601String(),
      'isVerified': isVerified,
      'status': status,
    };
  }
}
