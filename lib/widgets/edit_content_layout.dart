import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

class EditContentLayout extends StatelessWidget {
  const EditContentLayout({super.key, required this.itemList});

  final List<Widget> itemList;

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: !theme
            ? ColorsLightTheme.backgroundColor
            : const Color.fromRGBO(36, 36, 36, 1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.only(top: 16, bottom: 0, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: itemList,
      ),
    );
  }
}
