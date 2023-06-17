import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const AppBarCustom({
    super.key,
    required this.selectedIndex,
    required this.showFilterModal,
    required this.theme,
  });

  final int selectedIndex;
  final void Function(BuildContext ctx) showFilterModal;
  final bool theme;

  String get pageTitleGetter {
    switch (selectedIndex) {
      case (0):
        return 'notepinr';
      case (1):
        return 'plans';
      case (2):
        return 'notes done';
      case (3):
        return 'settings';
      default:
        return 'notepinr';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = pageTitleGetter;
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        child: AppBar(
          title: Text(
            pageTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: ColorsLightTheme.primaryColor,
            ),
          ),
          backgroundColor: !theme ? Colors.white : Colors.black,
          toolbarHeight: 64,
          centerTitle: false,
          scrolledUnderElevation: 0.0,
          actions: selectedIndex == 0
              ? <Widget>[
                  IconButton(
                    onPressed: () => showFilterModal(context),
                    icon: const Icon(Icons.filter_list),
                    // color: const Color.fromRGBO(255, 255, 255, 1),
                  )
                ]
              : null,
        ),
      ),
    );
  }
}
