class AssessmentModel {
  final String farmId;
  final String issuesFound;
  final String recommendation;
  final DateTime assessmentDate;

  AssessmentModel({
    required this.farmId,
    required this.issuesFound,
    required this.recommendation,
    required this.assessmentDate,
  });

  Map<String, dynamic> toJson() => {
        'farmId': farmId,
        'issuesFound': issuesFound,
        'recommendation': recommendation,
        'assessmentDate': assessmentDate.toIso8601String(),
      };

  static AssessmentModel fromJson(Map<String, dynamic> json) => AssessmentModel(
        farmId: json['farmId'],
        issuesFound: json['issuesFound'],
        recommendation: json['recommendation'],
        assessmentDate: DateTime.parse(json['assessmentDate']),
      );
}