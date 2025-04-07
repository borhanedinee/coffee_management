import 'package:coffee_shop_managementt/data/models/daily_sessions_model.dart';
import 'package:coffee_shop_managementt/data/models/session_model.dart';

abstract class SessionRepository {
  Future<List<DailySessionsModel>> fetchAndGroupPreviousSessions();
  Future<int> addSession(SessionModel session);
  Future<int> deleteSession(int sessionID);
}
