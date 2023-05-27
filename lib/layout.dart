import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:notpin/screens/homepage.dart';
import 'package:notpin/utils/notification_api.dart';
import 'package:notpin/widgets/bottom_sheet_content.dart';
import 'package:notpin/widgets/sort_filter_content.dart';
import 'package:notpin/screens/add_note.dart';
import 'package:notpin/screens/plans_page.dart';
import 'package:notpin/screens/checked_page.dart';
import 'package:notpin/screens/settings.dart';
import 'package:notpin/utils/db_helper.dart';
import 'package:notpin/utils/notification_api.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  var _notesList = [];

  Future<void> _getNotes() async {
    var res = await DBHelper.getAllNotes('notes_list');
    print(res);
    List<Map<String, Object?>> pinnedNotes =
        res.where((note) => note['pinned'] == 1).toList();

    print(pinnedNotes);

    if (pinnedNotes.isNotEmpty) {
      for (var i = 0; i < pinnedNotes.length; i++) {
        NotificationAPI.showNotification(
          pinnedNotes[i]['id'] as int,
          pinnedNotes[i]['title'] as String,
          pinnedNotes[i]['description'] as String,
          pinnedNotes[i]['priority'] as String,
        );
      }
    } else {
      NotificationAPI.removeAllPinnedNotifications();
    }
    setState(() {
      _notesList = res.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // DBHelper.deleteAllNotes('notes_list');
    _getNotes();
  }

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  void _showFilterModal(ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return const BottomSheetContent(
          height: 0.7,
          child: SortFilterContent(),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screensList = [
      HomePage(
        notes: _notesList,
      ),
      PlansPage(),
      CheckedPage(),
      Settings()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('notpin'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _showFilterModal(context),
            icon: const Icon(Icons.filter_list),
            color: const Color.fromRGBO(255, 255, 255, 1),
          )
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: _screensList[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? Icons.monetization_on
                  : Icons.monetization_on_outlined,
            ),
            label: 'Plans',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            label: 'Checked',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).appBarTheme.foregroundColor,
        unselectedItemColor:
            Theme.of(context).appBarTheme.foregroundColor?.withOpacity(0.66),
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        selectedFontSize: 12,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AddNote()),
            ),
          ).then((value) => _getNotes());
        },
        elevation: 5,
        backgroundColor: const Color.fromRGBO(59, 130, 246, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
