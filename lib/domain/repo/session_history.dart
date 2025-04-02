import 'package:coffee_shop_managementt/data/models/session_model.dart';

abstract class SessionRepository {
  Future<List<SessionModel>> fetchPreviousSessions();
  Future<int> addSession(SessionModel session);
  Future<int> deleteSession(int sessionID);
}
