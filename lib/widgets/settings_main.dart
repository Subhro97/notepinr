import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notepinr/provider/notes_provider.dart';
import 'package:notepinr/provider/theme_provider.dart';

import 'package:notepinr/widgets/settings_container_layout.dart';
import 'package:notepinr/widgets/settings_list_item.dart';

import 'package:notepinr/helpers/settings_helpers.dart';

class SettingsMain extends ConsumerStatefulWidget {
  const SettingsMain({super.key});

  @override
  ConsumerState<SettingsMain> createState() => _SettingsMainState();
}

class _SettingsMainState extends ConsumerState<SettingsMain> {
  Future<dynamic> dialogHandler(
    BuildContext context,
    String title,
    String subTxt,
    WidgetRef ref,
    bool theme,
  ) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: !theme
                ? Colors.black
                : const Color.fromRGBO(250, 250, 250, 0.87),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Oxygen',
          ),
        ),
        content: Text(
          subTxt,
          style: TextStyle(
            color: !theme
                ? Colors.black
                : const Color.fromRGBO(250, 250, 250, 0.87),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Oxygen',
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (title == 'Delete all Notes') {
                SettingsHelpers.deleteAllNotes();
              } else {
                SettingsHelpers.removeAllPins();
              }
              ref.read(notesProvider.notifier).setNotesFromDB();
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return SettingsContainerLayout(
      heading: 'Settings',
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SettingsListItem(
                  title: 'Theme',
                  subTitle: 'Select App Theme',
                  icon: Icons.invert_colors,
                  onTap: null,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (() async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('theme', 'Light');
                        ref.read(themeProvider.notifier).changeTheme(true);
                      }),
                      child: Column(
                        children: [
                          Icon(
                            !theme ? Icons.wb_sunny : Icons.wb_sunny_outlined,
                            size: 28,
                          ),
                          const Text(
                            'Light',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              // fontFamily: 'Oxygen',
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('theme', 'Dark');
                        ref.read(themeProvider.notifier).changeTheme(false);
                      },
                      child: Column(
                        children: [
                          Icon(
                            theme
                                ? Icons.nightlight
                                : Icons.nightlight_outlined,
                            size: 28,
                          ),
                          const Text(
                            'Dark',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              // fontFamily: 'Oxygen',
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            SettingsListItem(
              title: 'Unpin All Notes',
              subTitle: 'Removes all from Notification Bar',
              icon: Icons.push_pin_outlined,
              onTap: () => dialogHandler(context, 'Unpin all Notes',
                  'All Pinned notes will be Unpinned!', ref, theme),
            ),
            const SizedBox(
              height: 24,
            ),
            SettingsListItem(
              title: 'Delete All Notes',
              subTitle: 'Deletes all Notes',
              icon: Icons.delete_outline,
              onTap: () => dialogHandler(context, 'Delete all Notes',
                  'All your saved notes will be Deleted!', ref, theme),
            ),
          ],
        ),
      ),
    );
  }
}
