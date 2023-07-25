import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepinr/widgets/detail_card.dart';
import 'package:share_plus/share_plus.dart';

import 'package:notepinr/provider/notes_provider.dart';
import 'package:notepinr/provider/card_mode_provider.dart';

import 'package:notepinr/screens/add_note.dart';

import 'package:notepinr/widgets/bottom_sheet_content.dart';
import 'package:notepinr/widgets/edit_content.dart';
import 'package:notepinr/widgets/edit_item.dart';
import 'package:notepinr/widgets/edit_content_layout.dart';
import 'package:notepinr/widgets/note_card_layout.dart';
import 'package:notepinr/widgets/list_card.dart';

import 'package:notepinr/utils/db_helper.dart';
import 'package:notepinr/utils/notification_api.dart';

class NoteCard extends ConsumerStatefulWidget {
  final String priority;
  final String title;
  final String text;
  final int id;
  final String date;
  final String time;
  final bool isCheckedPage;
  final String noteType;

  const NoteCard({
    super.key,
    required this.id,
    required this.priority,
    required this.title,
    required this.text,
    required this.date,
    required this.time,
    required this.noteType,
    this.isCheckedPage = false,
  });

  @override
  ConsumerState<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends ConsumerState<NoteCard> {
  // Opens the edit modal screen
  void _showEditModal(ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return BottomSheetContent(
          height: widget.isCheckedPage ? 320 : 370,
          child: EditContent(
            key: ValueKey(widget.id),
            noteID: widget.id,
            title: widget.title,
            description: widget.text,
            priority: widget.priority,
            isCheckedPage: widget.isCheckedPage,
            onOpenDeleteModal: () => _deleteModalOpen(widget.id),
            onClone: (pinned, date, time) => _cloneHandler(
              widget.id,
              widget.title,
              widget.text,
              pinned,
              widget.priority,
            ),
            onChecked: (bool checkedStatus, bool pinStatus) =>
                _checkedHandler(checkedStatus, pinStatus),
            onShare: () => _shareNoteHandler(),
          ),
        );
      }),
    );
  }

  void _checkedHandler(bool checkedStatus, bool pinStatus) async {
    try {
      await DBHelper.updateCheckedStatus('test_db', widget.id, !checkedStatus);
      if (pinStatus) {
        NotificationAPI.removePinnedNotifications(
            widget.id); // Removing Notification Pinned in notification bar
        await DBHelper.updatePinStatus(
            'test_db', widget.id, 0); // Setting pin sattus in DB to false
      }
      Navigator.pop(context);
      ref.read(notesProvider.notifier).setNotesFromDB();
    } catch (error) {
      print(error);
    }
  }

  void _shareNoteHandler() async {
    Navigator.pop(context);
    Share.share('${widget.title}\n\n${widget.text}\n\n~ From notepinr');
  }

  // Pushes the Delete Modal screen after removing the edit modal screen
  void _deleteModalOpen(
    int noteID,
  ) {
    Navigator.of(context).pop();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: ((ctx) {
        return BottomSheetContent(
          height: 203,
          child: EditContentLayout(
            itemList: [
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  'Delete this Note?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              EditItem(
                type: 'delete',
                value: null,
                onTapHandler: () => _deleteHandler(noteID),
              ),
              EditItem(
                type: 'cancel',
                value: null,
                onTapHandler: (() {
                  Navigator.pop(context);
                }),
              )
            ],
          ),
        );
      }),
    );
  }

  // Deletes the notes & closes the delete modal
  void _deleteHandler(int noteID) {
    DBHelper.deleteNote('test_db', noteID);
    NotificationAPI.removePinnedNotifications(noteID);
    ref.read(notesProvider.notifier).setNotesFromDB();
    Navigator.of(context).pop();
  }

  void _cloneHandler(
    int noteID,
    String title,
    String description,
    bool pinned,
    String priority,
  ) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) {
          return AddNote(
            title: title,
            description: description,
            pinStatus: pinned,
            priority: priority,
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime _now = DateTime.now();

    final noteCardMode = ref.watch(cardModeProvider); // To obtain the card mode

    print(noteCardMode);
    return NoteCardLayout(
      priority: widget.priority,
      itemList: noteCardMode == 'detail' ||
              noteCardMode == null ||
              noteCardMode == 'grid'
          ? DetailCard(
              title: widget.title,
              priority: widget.priority,
              isCheckedPage: widget.isCheckedPage,
              text: widget.text,
              time: widget.time,
              date: widget.date,
              noteType: widget.noteType,
              now: _now,
              showEditModal: () => _showEditModal(context),
            )
          : ListCard(
              title: widget.title,
              priority: widget.priority,
              isCheckedPage: widget.isCheckedPage,
              text: widget.text,
              time: widget.time,
              date: widget.date,
              now: _now,
              showEditModal: () => _showEditModal(context),
            ),
    );
  }
}
