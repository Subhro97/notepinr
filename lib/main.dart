import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:notpin/layout.dart';
import 'package:notpin/utils/notification_api.dart';

var lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(59, 130, 246, 1),
);

var darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(18, 18, 18, 1),
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    NotificationAPI.flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings(
          '@mipmap/ic_launcher'), // Replace with your app icon name
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notpin',
      theme: ThemeData(fontFamily: 'Oxygen').copyWith(
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
      ),
      home: const Layout(),
    );
  }
}
