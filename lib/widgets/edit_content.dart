import 'package:flutter/material.dart';

import 'package:notepinr/utils/db_helper.dart';
import 'package:notepinr/utils/notification_api.dart';
import 'package:page_transition/page_transition.dart';

import 'package:notepinr/screens/add_note.dart';

import 'package:notepinr/widgets/edit_item.dart';
import 'package:notepinr/widgets/edit_content_layout.dart';

class EditContent extends StatefulWidget {
  const EditContent({
    super.key,
    required this.noteID,
    required this.title,
    required this.description,
    required this.priority,
    required this.onOpenDeleteModal,
    required this.onClone,
    required this.onChecked,
    required this.onShare,
  });

  final int noteID;
  final String title;
  final String description;
  final String priority;
  final void Function() onOpenDeleteModal;
  final void Function(
    // BuildContext cloneCtx,
    bool pinned,
    DateTime? date,
    TimeOfDay? time,
  ) onClone;
  final void Function(bool checkedStatus, bool pinStatus) onChecked;
  final void Function() onShare;

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  bool _pinned = false;
  bool _checkedStatus = false;
  late final res;

  @override
  initState() {
    super.initState();
    DBHelper.getNote('notepinr_notes_list', widget.noteID)
        .then(((value) => res = value));

    DBHelper.getPinNcheckedStatus(
      'notepinr_notes_list',
      widget.noteID,
    ).then((value) {
      _pinned = value['pinned']!;
      _checkedStatus = value['checked']!;
      setState(() {});
    });
  }

  Future<void> _pinHandler() async {
    setState(() {
      _pinned = !_pinned;
    });
    !_pinned
        ? NotificationAPI.removePinnedNotifications(widget.noteID)
        : NotificationAPI.showNotification(
            widget.noteID,
            widget.title,
            widget.description,
            widget.priority,
          );
    DBHelper.updatePinStatus(
      'notepinr_notes_list',
      widget.noteID,
      _pinned ? 1 : 0,
    );
  }

  void _editHandler() {
    Navigator.of(context).pop();

    Navigator.push(
      context,
      PageTransition(
        curve: Curves.linear,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 300),
        child: AddNote(
          type: 'edit',
          noteID: widget.noteID,
          title: res[0]['title'],
          description: res[0]['description'],
          pinStatus: res[0]['pinned'] == 1 ? true : false,
          priority: res[0]['priority'],
          date: res[0]['date'],
          time: res[0]['time'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EditContentLayout(
      itemList: [
        EditItem(
          type: 'edit',
          value: null,
          onTapHandler: _editHandler,
        ),
        EditItem(
          type: 'done',
          value: _checkedStatus,
          onTapHandler: () => widget.onChecked(_checkedStatus, _pinned),
        ),
        if (!_checkedStatus)
          EditItem(
            type: 'pin',
            value: _pinned,
            onTapHandler: _pinHandler,
          ),
        EditItem(
          type: 'clone',
          value: null,
          onTapHandler: () => widget.onClone(
            // context,
            res[0]['pinned'] == 1 ? true : false,
            null,
            null,
          ),
        ),
        EditItem(
          type: 'share',
          value: null,
          onTapHandler: () => widget.onShare(),
        ),
        EditItem(
          type: 'delete',
          value: null,
          onTapHandler: (() => widget.onOpenDeleteModal()),
        )
      ],
    );
  }
}
