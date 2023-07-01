import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notepinr/layout.dart';
import 'package:notepinr/provider/theme_provider.dart';
import 'package:notepinr/utils/notification_api.dart';
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

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings(
          '@drawable/notification_logo'), // Replace with your app icon name
    ),
  );

  runApp(
    const ProviderScope(
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
            title: 'notepinr',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: const Layout(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'notepinr',
            theme: theme ? lightTheme : darkTheme,
            home: const Layout(),
          );
  }
}
