import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/models/session_model.dart';
import 'package:coffee_shop_managementt/domain/repo/session_history.dart';

class SessionRepositoryImp extends SessionRepository {
  final DatabaseHelper dbHelper;

  SessionRepositoryImp(this.dbHelper);

  @override
  Future<int> addSession(SessionModel session) async {
    return await dbHelper.addSession(session);
  }

  @override
  Future<int> deleteSession(int sessionID) async {
    return await dbHelper.deleteSession(sessionID);
  }

  @override
  Future<List<SessionModel>> fetchPreviousSessions() async {
    List<Map<String, dynamic>> previousSessions =
        await dbHelper.fetchSessions();
    List<SessionModel> sessions = previousSessions.map((session) {
      return SessionModel.fromMap(session);
    }).toList();
    return sessions;
  }
}
