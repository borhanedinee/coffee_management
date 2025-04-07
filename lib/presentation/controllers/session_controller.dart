import 'package:coffee_shop_managementt/core/services/snackbars.dart';
import 'package:coffee_shop_managementt/data/models/daily_sessions_model.dart';
import 'package:coffee_shop_managementt/data/models/session_model.dart';
import 'package:coffee_shop_managementt/domain/repo/session_history.dart';
import 'package:coffee_shop_managementt/presentation/controllers/end_day_controller.dart';
import 'package:coffee_shop_managementt/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionController extends GetxController {
  SessionRepository sessionRepository;

  SessionController(this.sessionRepository);

  // PREVIOUS SESSIONS
  List<DailySessionsModel> gouppedDailySessions = [];
  bool isFetchingPreviousSessions = false;
  Future<void> fetchPreviousSessions() async {
    try {
      isFetchingPreviousSessions = true;
      update();
      await Future.delayed(Duration(seconds: 3));

      gouppedDailySessions =
          await sessionRepository.fetchAndGroupPreviousSessions();

      isFetchingPreviousSessions = false;
      update();
    } catch (e) {
      isFetchingPreviousSessions = false;
      update();
      SnackbarService.show(message: 'Error fetching previous sessions $e');
    }
  }

  // ADD SESSION
  void addSession(SessionModel session) {
    try {
      sessionRepository.addSession(session);
      Get.find<EndDayController>().clearEndDay();
      Get.offAll(HomeScreen());
      SnackbarService.show(message: 'session added successfully');
    } catch (e) {
      SnackbarService.show(message: 'Error adding a sessions $e');
    }
  }

  // DELETE SESSION
  void deleteSession(int sessionID) {
    try {
      sessionRepository.deleteSession(sessionID);
      update();
    } catch (e) {
      SnackbarService.show(message: 'Error deleting a sessions $e');
    }
  }
}
