import 'package:store_redirect/store_redirect.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:notpin/utils/db_helper.dart';

class SettingsHelpers {
  static void rateAppHandler() {
    StoreRedirect.redirect(
      androidAppId: 'com.vg.notepin',
    );
  }

  static void shareAppHandler() {
    Share.share(
        '📌 Never miss a beat! NotePinr keeps your important reminders within reach, right in your notification bar. \n\n Download now:  https://play.google.com/store/apps/details?id=com.vg.notepin');
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
              ? 'Found a Bug in NotePinr'
              : 'Feedback for improving NotePinr',
          'body':
              'Device Name: $deviceName \n Device Model: $deviceModel \n Android Version: $androidVersion \n Android Version Code: $androidVerCode',
        },
      ),
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email application.');
    }
  }

  static void deleteAllNotes() {
    DBHelper.deleteAllNotes('notes_list');
  }
}
