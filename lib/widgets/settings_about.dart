import 'package:flutter/material.dart';

import 'package:notepinr/widgets/settings_container_layout.dart';
import 'package:notepinr/widgets/settings_list_item.dart';

import 'package:notepinr/helpers/settings_helpers.dart';

class SettingsAbout extends StatelessWidget {
  const SettingsAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainerLayout(
      heading: 'About',
      child: Column(
        children: [
          const SettingsListItem(
            title: 'Version',
            subTitle: '1.1.1',
            icon: Icons.stay_current_portrait,
            onTap: null,
          ),
          const SizedBox(
            height: 24,
          ),
          const SettingsListItem(
            title: 'Rate App',
            subTitle: 'Tap and Drop a small review or rating',
            icon: Icons.star_border,
            onTap: SettingsHelpers.rateAppHandler,
          ),
          const SizedBox(
            height: 24,
          ),
          const SettingsListItem(
            title: 'Share App',
            subTitle: 'Tap to Share App with Friends and Family',
            icon: Icons.share_outlined,
            onTap: SettingsHelpers.shareAppHandler,
          ),
          const SizedBox(
            height: 24,
          ),
          SettingsListItem(
            title: 'Suggestions',
            subTitle: 'Send your ideas to improve app',
            icon: Icons.chat_bubble_outline,
            onTap: () => SettingsHelpers.suggestionNbugHandler('suggestion'),
          ),
          const SizedBox(
            height: 24,
          ),
          SettingsListItem(
            title: 'Report Bug',
            subTitle: 'Report any Issues faced in App',
            icon: Icons.bug_report_outlined,
            onTap: () => SettingsHelpers.suggestionNbugHandler('bug'),
          ),
          const SizedBox(
            height: 24,
          ),
          SettingsListItem(
            title: 'Privacy Policy',
            subTitle: 'Notepinr Privacy Policy',
            icon: Icons.privacy_tip_outlined,
            onTap: () => SettingsHelpers.privacyUrlLauncher(),
          ),
        ],
      ),
    );
  }
}
