import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

class EditContentLayout extends StatelessWidget {
  const EditContentLayout({super.key, required this.itemList});

  final List<Widget> itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsLightTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(
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
