import 'package:coffee_shop_managementt/data/datasources/db_helper.dart';
import 'package:coffee_shop_managementt/data/models/daily_sessions_model.dart';
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
  Future<List<DailySessionsModel>> fetchAndGroupPreviousSessions() async {
    List<Map<String, dynamic>> previousSessions =
        await dbHelper.fetchSessions();

    // Convert to SessionModel objects
    final sessions =
        previousSessions.map((map) => SessionModel.fromMap(map)).toList();

    // Group sessions by date
    final Map<String, DailySessionsModel> groupedSessions = {};

    for (var session in sessions) {
      if (session.sessionDate == null) continue; // Skip sessions without a date

      // Extract the date part (yyyy-MM-dd)
      final dateKey = DateTime(
        session.sessionDate!.year,
        session.sessionDate!.month,
        session.sessionDate!.day,
      );

      // Initialize the DailySessionsModel entry if it doesn't exist
      if (!groupedSessions.containsKey(dateKey.toString())) {
        groupedSessions[dateKey.toString()] = DailySessionsModel(
          date: dateKey,
          morningSession: null,
          eveningSession: null,
        );
      }

      // Assign the session to morning or evening
      final dailySession = groupedSessions[dateKey.toString()]!;
      if (session.period == SessionPeriod.morning) {
        dailySession.morningSession = session;
      } else if (session.period == SessionPeriod.evening) {
        dailySession.eveningSession = session;
      }
    }

    // Convert the map to a list and sort by date
    final dailySessionsModelList = groupedSessions.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date)); // Sort by date descending

    return dailySessionsModelList;
  }
}
