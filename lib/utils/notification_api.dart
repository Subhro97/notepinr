import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:notepinr/utils/file_path.dart';

class NotificationAPI {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); // Initializing the Notification Plugin

  static Future<void> showNotification(
    int id,
    String title,
    String body,
    String priority,
  ) async {
    var subPath = _getPriorityIcon(priority);
    var path = await FilePath.getFilePath('assets/images/$subPath',
        subPath); // Getting the path of the priority icon stored in somewhere in the device

    String newBody = ''; // To store body text for checklist

    if (isJSONString(body)) {
      List checklistArr = jsonDecode(body);
      checklistArr.forEach((elm) {
        if (elm['isChecked'] == true) {
          newBody += elm['text'] + "\s" + " ✓" + '\n';
        } else {
          newBody += elm['text'] + '\n';
        }
      });

      body = newBody;
    }

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      contentTitle: title,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: _getPriority(priority),
      ongoing: true,
      autoCancel: false,
      enableVibration: false,
      largeIcon: FilePathAndroidBitmap(path),
      color: Color.fromRGBO(59, 130, 246, 1),
      styleInformation: bigTextStyleInformation,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'unpin_$id',
          'Unpin',
          cancelNotification: false,
        ),
      ],
    ); // Customizing the Notification

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body == '' ? '' : body,
      notificationDetails,
      payload: _getPriority(priority).toString(),
    );
  }

  static Future<void> removeAllPinnedNotifications() async {
    return await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> removePinnedNotifications(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<List<ActiveNotification>> listOfActiveNotifications() async {
    return await flutterLocalNotificationsPlugin.getActiveNotifications();
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

  static String _getPriorityIcon(String priority) {
    switch (priority) {
      case 'High':
        return 'high.png';
      case 'Medium':
        return 'medium.png';
      case 'Low':
        return 'low.png';
      default:
        return 'low.png';
    }
  }

  static bool isJSONString(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true; // It's a valid JSON-encoded string
    } catch (e) {
      return false; // It's not a valid JSON-encoded string
    }
  }
}
