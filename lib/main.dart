import 'package:flutter/material.dart';
import "package:flutter/services.dart";

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notpin/layout.dart';
import 'package:notpin/provider/theme_provider.dart';
import 'package:notpin/screens/search_note.dart';
import 'package:notpin/utils/notification_api.dart';
import 'package:notpin/screens/custom_page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

var lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(59, 130, 246, 1),
);

var kdarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromRGBO(59, 130, 246, 1),
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

  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     systemNavigationBarColor: Colors.transparent.withOpacity(0.3),
  //     systemNavigationBarDividerColor: Colors.transparent,
  //     systemNavigationBarIconBrightness: Brightness.light,
  //   ),
  // );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

  // runApp(
  //   TestScreen(),
  // );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
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
    });
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
            debugShowCheckedModeBanner: false,
            title: 'Notpin',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: const Layout(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notpin',
            theme: theme ? lightTheme : darkTheme,
            home: const Layout(),
          );
  }
}
