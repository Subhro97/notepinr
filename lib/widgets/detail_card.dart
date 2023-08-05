import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:notepinr/widgets/note_card_layout.dart';

class DetailCard extends StatefulWidget {
  final String priority;
  final String title;
  final String text;
  final String date;
  final String time;
  final bool isCheckedPage;
  final DateTime now;
  final String noteType;
  final Function() showEditModal;

  const DetailCard({
    super.key,
    required this.priority,
    required this.title,
    required this.text,
    required this.date,
    required this.time,
    required this.now,
    required this.showEditModal,
    required this.noteType,
    this.isCheckedPage = false,
  });

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    List<TextSpan> descriptionTxt = [];

    if (widget.noteType == 'checklist') {
      List<dynamic> descriptionChecklist = jsonDecode(widget.text);

      for (int i = 0; i < descriptionChecklist.length; i++) {
        if (descriptionChecklist[i]["isChecked"]) {
          descriptionTxt.add(
            TextSpan(
              text: i != descriptionChecklist.length - 1
                  ? "${i + 1}. " + descriptionChecklist[i]["text"] + '\n'
                  : "${i + 1}. " + descriptionChecklist[i]["text"],
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2.5,
                fontSize: 16,
              ),
            ),
          );
        } else {
          descriptionTxt.add(
            TextSpan(
              text: i != descriptionChecklist.length - 1
                  ? "${i + 1}. " + descriptionChecklist[i]["text"] + '\n'
                  : "${i + 1}. " + descriptionChecklist[i]["text"],
              style: const TextStyle(fontSize: 16),
            ),
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  color:
                      NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  overflow: TextOverflow.ellipsis,
                ),
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
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: NoteCardLayout.cardTxtColor(widget.priority, 'txtColor'),
            ),
            children: widget.noteType == 'checklist'
                ? descriptionTxt
                : widget.text
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
