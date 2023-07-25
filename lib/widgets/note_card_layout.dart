import 'package:flutter/material.dart';

import 'package:notepinr/utils/colors.dart';

class NoteCardLayout extends StatelessWidget {
  const NoteCardLayout({
    super.key,
    required this.itemList,
    required this.priority,
  });

  final Widget? itemList;
  final String priority;

  static Color? cardTxtColor(value, caseVal) {
    switch (caseVal) {
      case 'background':
        return value == 'High'
            ? ColorsLightTheme.priorityHigh
            : value == 'Medium'
                ? ColorsLightTheme.priorityMedium
                : ColorsLightTheme.priorityLow;

      case 'txtColor':
        return value == 'High'
            ? ColorsLightTheme.priorityHighTxt
            : value == 'Medium'
                ? ColorsLightTheme.priorityMediumTxt
                : ColorsLightTheme.priorityLowTxt;

      case 'tagColor':
        return value == 'High'
            ? ColorsLightTheme.priorityHighTag
            : value == 'Medium'
                ? ColorsLightTheme.priorityMediumTag
                : ColorsLightTheme.priorityLowTag;

      case 'tagTxt':
        return value == 'High'
            ? ColorsLightTheme.priorityHighTagTxt
            : value == 'Medium'
                ? ColorsLightTheme.priorityMediumTagTxt
                : ColorsLightTheme.priorityLowTagTxt;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: cardTxtColor(priority, 'background'),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: const Offset(0, 2), // Offset for the shadow
            blurRadius: 2, // Blur radius
            spreadRadius: 0.5, // Spread radius
          ),
        ],
      ),
      child: itemList,
    );
  }
}
