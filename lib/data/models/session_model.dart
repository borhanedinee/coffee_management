import 'package:get/get.dart';

enum SessionPeriod {
  morning,
  evening,
}

enum SessionStatus {
  suspicious,
  normal,
}

class SessionModel {
  final int? id;
  final double priceInCaisse;
  final double priceCalculatedByApp;
  final DateTime? sessionDate;
  final SessionPeriod period; // New field
  final SessionStatus? status; // New field
  final double toleranceValue; // Optional field

  SessionModel({
    this.id,
    required this.priceInCaisse,
    required this.priceCalculatedByApp,
    this.sessionDate,
    required this.period, // Make required
    this.status, // Make required
    required this.toleranceValue,
  });

  factory SessionModel.fromMap(Map<String, dynamic> map) => SessionModel(
      id: map['id'],
      priceInCaisse: map['priceInCaisse'],
      priceCalculatedByApp: map['priceCalculatedByApp'],
      toleranceValue: map['toleranceValue'],
      sessionDate: map['sessionDate'] != null
          ? DateTime.parse(map['sessionDate'])
          : null,
      period: SessionPeriod.values.firstWhere(
        (e) => e.toString() == map['period'],
        orElse: () => SessionPeriod.morning, // Default if not found
      ),
      status: SessionStatus.values.firstWhereOrNull(
        (e) => e.toString() == map['status'],
      ));

  Map<String, dynamic> toMap() => {
        'id': id,
        'priceInCaisse': priceInCaisse,
        'priceCalculatedByApp': priceCalculatedByApp,
        'sessionDate': sessionDate?.toIso8601String(),
        'period': period.toString(), // e.g., "SessionPeriod.morning"
        'status': status?.toString(), // e.g., "SessionStatus.suspicious"
        'toleranceValue': toleranceValue,
      };
}
