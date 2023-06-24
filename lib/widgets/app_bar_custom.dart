import 'package:flutter/material.dart';

import 'package:notepinr/utils/colors.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
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

  @override
  State<AppBarCustom> createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  String get pageTitleGetter {
    switch (widget.selectedIndex) {
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
          backgroundColor: !widget.theme ? Colors.white : Colors.black,
          toolbarHeight: 64,
          centerTitle: false,
          scrolledUnderElevation: 0.0,
          actions: widget.selectedIndex == 0
              ? <Widget>[
                  IconButton(
                    onPressed: () => widget.showFilterModal(context),
                    icon: const Icon(Icons.filter_list),
                    color: !widget.theme ? Colors.black : Colors.white,
                  )
                ]
              : null,
        ),
      ),
    );
  }
}
