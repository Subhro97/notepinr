import 'package:flutter/material.dart';

import 'package:notpin/widgets/settings_container_layout.dart';
import 'package:notpin/widgets/settings_list_item.dart';

import 'package:notpin/helpers/settings_helpers.dart';

class SettingsMain extends StatelessWidget {
  const SettingsMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainerLayout(
      heading: 'Settings',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SettingsListItem(
                title: 'Theme',
                subTitle: 'Select App Theme',
                icon: Icons.invert_colors,
                onTap: SettingsHelpers.deleteAllNotes,
              ),
              Row(
                children: [
                  Column(
                    children: const [
                      Icon(Icons.wb_sunny),
                      Text(
                        'Light',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    children: const [
                      Icon(
                        Icons.nightlight_outlined,
                      ),
                      Text(
                        'Dark',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const SettingsListItem(
            title: 'Unpin All Notes',
            subTitle: 'Removes all from Notification Bar',
            icon: Icons.push_pin_outlined,
            onTap: null,
          ),
          const SizedBox(
            height: 24,
          ),
          const SettingsListItem(
            title: 'Delete All Notes',
            subTitle: 'Deletes all Notes',
            icon: Icons.delete_outline,
            onTap: null,
          ),
        ],
      ),
    );
    ;
  }
}
