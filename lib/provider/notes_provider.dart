import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notpin/utils/db_helper.dart';

class NotesNotifier extends StateNotifier<List<Map<String, Object?>>> {
  NotesNotifier() : super([]);

  Future<void> setNotesFromDB() async {
    var res = await DBHelper.getAllNotes('notes_list');
    List<Map<String, Object?>> unCheckedNotes = res.where(
      (note) {
        return (note['checked'] == 0);
      },
    ).toList();

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
