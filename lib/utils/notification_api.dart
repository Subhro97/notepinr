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
    print(path);
    print("spidey");
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
    ); // Customizing the Notification
    print(androidNotificationDetails);
    print(flutterLocalNotificationsPlugin);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
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
}
