import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notepinr/utils/db_helper.dart';

class NotesNotifier extends StateNotifier<List<Map<String, Object?>>> {
  NotesNotifier() : super([]);

  Future<void> setNotesFromDB() async {
    var res = await DBHelper.getAllNotes('notepinr_notes_lists');
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Accessing the Shared Preferences Object
    String? sortType = prefs.getString('sort');
    String? filterType = prefs.getString('filter');

    // Sorting Notes by their respective options
    if (sortType == 'Priority' || sortType == null) {
      var highPriority = res
          .where((note) => note['priority'] == 'High')
          .toList()
          .reversed
          .toList();

      var medPriority = res
          .where((note) => note['priority'] == 'Medium')
          .toList()
          .reversed
          .toList();

      var lowPriority = res
          .where((note) => note['priority'] == 'Low')
          .toList()
          .reversed
          .toList();

      res = [...highPriority, ...medPriority, ...lowPriority];
    } else if (sortType == 'FirstToLast') {
      res = res.reversed.toList();
    } else {
      res = res;
    }

    // Filering Notes by Pinned status
    if (filterType == 'Pinned') {
      res = res.where((note) => note['pinned'] == 1).toList();
    }

    //Filter Notes which are not checked in DB
    List<Map<String, Object?>> unCheckedNotes = res.where(
      (note) {
        return (note['checked'] == 0);
      },
    ).toList();

    //Filter Notes which are  checked in DB
    List<Map<String, Object?>> checkedNotes = res.where(
      (note) {
        return (note['checked'] == 1);
      },
    ).toList();

    state = [
      {
        "unCheckedList": unCheckedNotes,
        "checkedList": checkedNotes,
      }
    ];
  }
}

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<Map<String, Object?>>>(((ref) {
  return NotesNotifier();
}));
