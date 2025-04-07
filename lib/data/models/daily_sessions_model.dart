import 'package:coffee_shop_managementt/data/models/session_model.dart';

class DailySessionsModel {
  final DateTime date; // The date (e.g., 2025-04-02)
  SessionModel? morningSession; // Morning session, if any
  SessionModel? eveningSession; // Evening session, if any

  DailySessionsModel({
    required this.date,
    this.morningSession,
    this.eveningSession,
  });
}
