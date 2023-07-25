import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notepinr/layout.dart';
import 'package:notepinr/provider/card_mode_provider.dart';
import 'package:notepinr/provider/theme_provider.dart';
import 'package:notepinr/screens/checked_page.dart';
import 'package:notepinr/utils/notification_api.dart';
import 'package:notepinr/utils/db_helper.dart';
import 'package:notepinr/provider/notes_provider.dart';
import 'package:notepinr/screens/add_checklist.dart';

import 'package:shared_preferences/shared_preferences.dart';

var lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(59, 130, 246, 1),
);

var kdarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromRGBO(59, 130, 246, 1),
);

ProviderContainer container = ProviderContainer();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    NotificationAPI.flutterLocalNotificationsPlugin;

String? selectedNotificationPayload;
String initialRoute = '';

@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  int notificationId = int.parse('${notificationResponse.id}');

  await DBHelper.updatePinStatus('notepinr_notes_list', notificationId, 0);
  NotificationAPI.removePinnedNotifications(notificationId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings(
          '@drawable/notification_logo'), // Replace with your app icon name
    ),
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    // SharedPreferences.getInstance().then((prefs) => prefs.remove('theme'));
    SharedPreferences.getInstance().then((prefs) {
      var value = prefs.getString('theme');
      if (value == 'Light') {
        ref.read(themeProvider.notifier).changeTheme(true);
      }
      if (value == 'Dark') {
        ref.read(themeProvider.notifier).changeTheme(false);
      }

      String? noteCardMode = prefs.getString('cardView');
      ref.read(cardModeProvider.notifier).setCardMode(noteCardMode);
    });
    _requestPermissions();
  }

  // Requesting permission for showing Notification
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    final ThemeData darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      // colorScheme: kdarkColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color.fromRGBO(36, 36, 36, 0.8),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        toolbarHeight: 64,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(255, 255, 255, 1),
          height: 1.27,
        ),
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText2: const TextStyle(
              fontFamily: 'Oxygen',
              color: Color.fromRGBO(250, 250, 250, 0.8),
            ),
            headline6: const TextStyle(
              fontFamily: 'Oxygen',
              color: Color.fromRGBO(250, 250, 250, 0.8),
            ),
          ),
      iconTheme: const IconThemeData(
        color: Color.fromRGBO(250, 250, 250, 0.8),
      ),
    );

    final lightTheme = ThemeData(fontFamily: 'Oxygen').copyWith(
      useMaterial3: true,
      // colorScheme: lightColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color.fromRGBO(59, 130, 246, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        toolbarHeight: 64,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(255, 255, 255, 1),
          height: 1.27,
        ),
      ),
    );

    return theme == null
        ? MaterialApp(
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
            title: 'notepinr',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: const Layout(),
          )
        : MaterialApp(
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
            title: 'notepinr',
            theme: theme ? lightTheme : darkTheme,
            home: const Layout(),
          );
  }
}
