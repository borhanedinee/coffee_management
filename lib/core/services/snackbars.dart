import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  // Default duration
  static const _defaultDuration = Duration(seconds: 2);

  // Basic snackbar with customizable options
  static void show({
    required String message,
    Duration duration = _defaultDuration,
    String? title,
    SnackPosition? position,
    Color? backgroundColor,
    bool? isDismissible,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        duration: duration,
        snackPosition: position ?? SnackPosition.TOP,
        backgroundColor: backgroundColor ?? Colors.grey.shade800,
        isDismissible: isDismissible ?? true,
      ),
    );
  }

  // Pre-configured success snackbar
  static void showSuccess(String message, {Duration? duration}) {
    show(
      message: message,
      duration: duration ?? _defaultDuration,
      backgroundColor: Colors.green,
    );
  }

  // Pre-configured error snackbar
  static void showError(String message, {Duration? duration}) {
    show(
      message: message,
      duration: duration ?? _defaultDuration,
      backgroundColor: Colors.red,
    );
  }
}
