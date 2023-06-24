import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:notepinr/provider/notes_provider.dart';

import 'package:notepinr/screens/add_note.dart';

import 'package:notepinr/widgets/bottom_sheet_content.dart';
import 'package:notepinr/widgets/edit_content.dart';
import 'package:notepinr/widgets/edit_item.dart';
import 'package:notepinr/widgets/edit_content_layout.dart';
import 'package:notepinr/widgets/note_card_layout.dart';

import 'package:notepinr/utils/db_helper.dart';
import 'package:notepinr/utils/notification_api.dart';

class NoteCard extends ConsumerStatefulWidget {
  final String priority;
  final String title;
  final String text;
  final int id;

  const NoteCard({
    super.key,
    required this.id,
    required this.priority,
    required this.title,
    required this.text,
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
          height: 0.47,
          child: EditContent(
            key: ValueKey(widget.id),
            noteID: widget.id,
            title: widget.title,
            description: widget.text,
            priority: widget.priority,
            onOpenDeleteModal: () => _deleteModalOpen(widget.id),
            onClone: (pinned, date, time) => _cloneHandler(
              widget.id,
              widget.title,
              widget.text,
              pinned,
              widget.priority,
              date,
              time,
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
    await DBHelper.updateCheckedStatus('notes_list', widget.id, !checkedStatus);
    if (pinStatus) {
      NotificationAPI.removePinnedNotifications(
          widget.id); // Removing Notification Pinned in notification bar
      await DBHelper.updatePinStatus(
          'notes_list', widget.id, 0); // Setting pin sattus in DB to false
    }
    Navigator.pop(context);
    ref.watch(notesProvider.notifier).setNotesFromDB();
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
          height: 0.27,
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
    DBHelper.deleteNote('notes_list', noteID);
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
    DateTime? date,
    TimeOfDay? time,
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
            date: date,
            time: time,
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NoteCardLayout(
      priority: widget.priority,
      itemList: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                color: NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: () => _showEditModal(context),
              icon: Icon(
                Icons.more_vert,
                color: NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
            ),
            children: widget.text
                .split('\n')
                .map(
                  (line) => TextSpan(
                    text: line + '\n',
                    style: const TextStyle(fontSize: 16),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: widget.priority == 'High'
              ? 47
              : widget.priority == 'Medium'
                  ? 60
                  : 40,
          height: 20,
          decoration: BoxDecoration(
            color: NoteCardLayout.cardTxtColor(widget.priority, 'tagColor'),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              widget.priority,
              style: TextStyle(
                color: NoteCardLayout.cardTxtColor(widget.priority, 'tagTxt'),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    );
  }
}
