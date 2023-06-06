import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notpin/widgets/bottom_sheet_content.dart';
import 'package:notpin/widgets/sort_filter_content.dart';

import 'package:notpin/provider/notes_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:notpin/screens/homepage.dart';
import 'package:notpin/screens/add_note.dart';
import 'package:notpin/screens/plans_page.dart';
import 'package:notpin/screens/checked_page.dart';
import 'package:notpin/screens/settings.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  int _selectedIndex = 0;
  var _notesList = [];
  var _checkedList = [];

  void _getNotes() {
    ref.read(notesProvider.notifier).setNotesFromDB();
  }

  @override
  void initState() {
    super.initState();
    // SharedPreferences.getInstance().then((prefs) => prefs.remove('sort'));
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
    final providerList =
        ref.watch(notesProvider); //Getting the state set proider List

    if (providerList.isNotEmpty) {
      //Filtering the List as per checked status;
      _notesList = (providerList[0]["unCheckedList"] as List).isNotEmpty
          ? (providerList[0]["unCheckedList"] as List)
          : [];
      _checkedList = (providerList[0]["checkedList"] as List).isNotEmpty
          ? (providerList[0]["checkedList"] as List)
          : [];
    } else {
      _notesList = [];
      _checkedList = [];
    }

    final List<Widget> screensList = [
      HomePage(
        notes: _notesList,
      ),
      const PlansPage(),
      CheckedPage(
        checkedNotes: _checkedList,
      ),
      const Settings()
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
        child: screensList[_selectedIndex],
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
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const AddNote()),
                  ),
                ).then((value) => _getNotes());
              },
              elevation: 5,
              backgroundColor: const Color.fromRGBO(59, 130, 246, 1),
              foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
