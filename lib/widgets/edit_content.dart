import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';
import 'package:notpin/utils/db_helper.dart';
import 'package:notpin/utils/notification_api.dart';
import 'package:notpin/widgets/edit_item.dart';

class EditContent extends StatefulWidget {
  const EditContent({
    super.key,
    required this.noteID,
    required this.title,
    required this.description,
    required this.priority,
  });

  final int noteID;
  final String title;
  final String description;
  final String priority;

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  bool _pinned = false;

  @override
  initState() {
    super.initState();

    DBHelper.getNotesPinStatus(
      'notes_list',
      widget.noteID,
    ).then((value) {
      _pinned = value;
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
      'notes_list',
      widget.noteID,
      _pinned ? 1 : 0,
    );
  }

  void _editHandler() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsLightTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
      child: Column(
        children: [
          // Row(
          //   children: const <Widget>[
          //     Icon(
          //       Icons.check,
          //       size: 20,
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     Text(
          //       'Mark as Done',
          //       style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     )
          //   ],
          // )

          EditItem(
            type: 'edit',
            value: null,
            onTapHandler: _editHandler,
          ),

          EditItem(
            type: 'pin',
            value: _pinned,
            onTapHandler: _pinHandler,
          )
        ],
      ),
    );
  }
}
