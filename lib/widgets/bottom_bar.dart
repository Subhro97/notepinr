import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final int selectedIndex;
  final void Function(int idx) onItemTap;

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      // height: 60,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0.0),
            blurRadius: 0.5,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: !theme
                ? Theme.of(context).appBarTheme.foregroundColor
                : Colors.black,
            selectedItemColor: !theme
                ? Theme.of(context).appBarTheme.backgroundColor
                : const Color.fromRGBO(97, 150, 234, 1),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            selectedIconTheme: IconThemeData(
              color: !theme
                  ? Theme.of(context).appBarTheme.backgroundColor
                  : const Color.fromRGBO(97, 150, 234, 1),
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: !theme
                  ? Colors.black54
                  : const Color.fromRGBO(250, 250, 250, 0.8).withOpacity(0.3),
            ),
            unselectedIconTheme: IconThemeData(
              color: !theme
                  ? const Color.fromRGBO(0, 0, 0, 0.7)
                  : const Color.fromRGBO(250, 250, 250, 0.8).withOpacity(0.3),
            ),
            unselectedItemColor: !theme
                ? Colors.black54
                : const Color.fromRGBO(250, 250, 250, 0.8).withOpacity(0.3),
            currentIndex: selectedIndex,
            selectedFontSize: 12,
            onTap: onItemTap,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outline,
                ),
                label: 'Info',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Checked',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
