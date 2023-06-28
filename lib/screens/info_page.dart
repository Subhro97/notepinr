import "package:flutter/material.dart";

import 'package:notepinr/widgets/settings_container_layout.dart';
import 'package:notepinr/widgets/faq_list.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingsContainerLayout(
            child: Text(
                'Thank you so much for downloading the app. I hope you find great use of the app. 😊 \n\nThe app is completely free and ad-free,  so you can enjoy all it\'s amazing features without any distractions. \n\nI just have a request to support the application by sharing it with your friends, family, and colleagues. \n\nTogether, let\'s make this app even more awesome! ❤️ '),
            heading: 'Developer\'s Note',
          ),
          FaqList(),
        ],
      ),
    );
  }
}
