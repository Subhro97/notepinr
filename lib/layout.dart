import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notepinr/utils/notification_api.dart';

import 'package:notepinr/widgets/bottom_sheet_content.dart';
import 'package:notepinr/widgets/sort_filter_content.dart';

import 'package:notepinr/provider/notes_provider.dart';

import 'package:notepinr/screens/homepage.dart';
import 'package:notepinr/screens/info_page.dart';
import 'package:notepinr/screens/checked_page.dart';
import 'package:notepinr/screens/settings.dart';

import 'package:notepinr/widgets/app_bar_custom.dart';
import 'package:notepinr/widgets/bottom_bar.dart';
import 'package:notepinr/widgets/search_bar_custom.dart';
import 'package:notepinr/widgets/change_card_view.dart';
import 'package:notepinr/widgets/note_type_select.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  static const String routeName = '/';

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  int _selectedIndex =
      0; // To store the current active index of the bottom nav bar
  var _notesList = []; // To store the list of notes of type unchecked from DB
  var _checkedList = []; // To store the list of notes of type checked from DB

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
          height: 500,
          child: SortFilterContent(),
        );
      }),
    );
  }

  void _showCardViewModal(ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return const BottomSheetContent(
          height: 282,
          child: ChangeCardView(),
        );
      }),
    );
  }

  void _showNoteTypeModal(BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return BottomSheetContent(
          height: 260,
          child: NoteTypeSelect(
            refContext: ctx,
            getNotes: _getNotes,
          ),
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
      const InfoPage(),
      CheckedPage(
        checkedNotes: _checkedList,
      ),
      const Settings()
    ];

    // If App started after reboot, to check if which notifications are pinned and show them in bar.
    NotificationAPI.listOfActiveNotifications().then((notificationList) {
      if (notificationList.isEmpty && _notesList.isNotEmpty) {
        _notesList.forEach((elm) {
          elm['pinned'] == 1
              ? NotificationAPI.showNotification(
                  elm['id'],
                  elm['title'],
                  elm['description'],
                  elm['priority'],
                )
              : '';
        });
      }
    }).catchError((error) {
      print(error);
    });

    bool theme = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: !theme ? Colors.white : Colors.black,
        systemNavigationBarDividerColor: !theme
            ? Color.fromARGB(255, 214, 214, 214).withOpacity(1)
            : const Color.fromARGB(255, 46, 46, 46).withOpacity(1),
        systemNavigationBarIconBrightness:
            !theme ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBarCustom(
          selectedIndex: _selectedIndex,
          showFilterModal: (ctx) => _showFilterModal(ctx),
          showCardViewModal: (ctx) => _showCardViewModal(ctx),
          theme: theme,
        ),
        backgroundColor: !theme ? Colors.white : Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _selectedIndex == 0
                ? const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
                    child: SearchBarCustom(),
                  )
                : const SizedBox(),
            Expanded(child: screensList[_selectedIndex]),
          ],
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
          onItemTap: _onItemTapped,
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () => _showNoteTypeModal(context),
                elevation: 5,
                backgroundColor: !theme
                    ? const Color.fromRGBO(59, 130, 246, 1)
                    : const Color.fromRGBO(97, 150, 234, 1),
                foregroundColor: !theme
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : const Color.fromRGBO(10, 54, 123, 1),
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
