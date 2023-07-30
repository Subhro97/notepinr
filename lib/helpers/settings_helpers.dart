import 'package:notepinr/utils/notification_api.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:notepinr/utils/db_helper.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsHelpers {
  static void rateAppHandler() async {
    if (!await launchUrlString(
      'https://play.google.com/store/apps/details?id=com.optimus.notepinr',
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch App Store!');
    }
  }

  static void shareAppHandler() {
    Share.share(
        '📌 Never miss a beat! notepinr keeps your important reminders within reach, right in your notification bar. \n\n Download now: https://play.google.com/store/apps/details?id=com.optimus.notepinr');
  }

  static Future<void> suggestionNbugHandler(String type) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    String deviceName = androidInfo.brand;
    String deviceModel = androidInfo.model;
    String androidVersion = androidInfo.version.release;
    String androidVerCode = androidInfo.version.sdkInt.toString();

    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'subhromond@gmail.com',
      query: encodeQueryParameters(
        <String, String>{
          'subject': type == 'bug'
              ? 'Found a Bug in notepinr'
              : 'Feedback for improving notepinr',
          'body':
              'Device Name: $deviceName \n Device Model: $deviceModel \n Android Version: $androidVersion \n Android Version Code: $androidVerCode',
        },
      ),
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email application.');
    }
  }

  static Future<void> privacyUrlLauncher() async {
    if (!await launchUrlString(
      'https://notepinr.web.app/',
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch URL!');
    }
  }

  static void deleteAllNotes() {
    DBHelper.deleteAllNotes('notepinr_notes_lists');
    NotificationAPI.removeAllPinnedNotifications();
  }

  static void removeAllPins() {
    NotificationAPI.removeAllPinnedNotifications();
    DBHelper.unPinAllNotes('notepinr_notes_lists');
  }
}
