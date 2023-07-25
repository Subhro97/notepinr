import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:notepinr/widgets/note_card_layout.dart';

class ListCard extends StatefulWidget {
  final String priority;
  final String title;
  final String text;
  final String date;
  final String time;
  final bool isCheckedPage;
  final DateTime now;
  final Function() showEditModal;

  const ListCard({
    super.key,
    required this.priority,
    required this.title,
    required this.text,
    required this.date,
    required this.time,
    required this.now,
    required this.showEditModal,
    this.isCheckedPage = false,
  });

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                color: NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 36,
              child: GestureDetector(
                onTap: widget.showEditModal,
                child: Icon(
                  Icons.more_vert,
                  color:
                      NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
                ),
              ),
            ),
          ],
        ),
        Text(
          DateFormat('dd-MM-yyyy').format(widget.now).toString() == widget.date
              ? widget.time
              : widget.date,
          style: TextStyle(
            color: NoteCardLayout.cardTxtColor(widget.priority, 'txtColor')!
                .withOpacity(0.85),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 12,
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
