import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> showNotification(
    int id,
    String title,
    String body,
    String priority,
  ) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: _getPriority(priority),
      ongoing: true,
      autoCancel: false,
      enableVibration: false,
      colorized: true,
      color: _getColor(priority),
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id++,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> removeAllPinnedNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Priority _getPriority(String notePriority) {
    switch (notePriority) {
      case 'High':
        return Priority.high;
      case 'Medium':
        return Priority.defaultPriority;
      case 'Low':
        return Priority.low;
      default:
        return Priority.defaultPriority;
    }
  }

  static Color _getColor(String notePriority) {
    switch (notePriority) {
      case 'High':
        return Colors.red; // Red color
      case 'Medium':
        return Colors.yellow; // Yellow color
      case 'Low':
        return Colors.green; // Green color
      default:
        return Colors.green; // Default color (white)
    }
  }
}
