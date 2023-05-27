import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';
import 'package:notpin/widgets/bottom_sheet_content.dart';
import 'package:notpin/widgets/edit_content.dart';

class NoteCard extends StatefulWidget {
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
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  Color? _cardTxtColor(value, caseVal) {
    switch (caseVal) {
      case 'background':
        return value == 'High'
            ? ColorsLightTheme.priorityHigh
            : value == 'Medium'
                ? ColorsLightTheme.priorityMedium
                : ColorsLightTheme.priorityLow;

      case 'txtColor':
        return value == 'High'
            ? ColorsLightTheme.priorityHighTxt
            : value == 'Medium'
                ? ColorsLightTheme.priorityMediumTxt
                : ColorsLightTheme.priorityLowTxt;

      case 'tagColor':
        return value == 'High'
            ? ColorsLightTheme.priorityHighTag
            : value == 'Medium'
                ? ColorsLightTheme.priorityMediumTag
                : ColorsLightTheme.priorityLowTag;

      case 'tagTxt':
        return value == 'High'
            ? ColorsLightTheme.priorityHighTagTxt
            : value == 'Medium'
                ? ColorsLightTheme.priorityMediumTagTxt
                : ColorsLightTheme.priorityLowTagTxt;

      default:
        return null;
    }
  }

  void _showEditModal(ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return BottomSheetContent(
          height: 0.4,
          child: EditContent(
            noteID: widget.id,
            title: widget.title,
            description: widget.text,
            priority: widget.priority,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardTxtColor(widget.priority, 'background'),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            offset: const Offset(0, 2), // Offset for the shadow
            blurRadius: 2, // Blur radius
            spreadRadius: 0.5, // Spread radius
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  color: _cardTxtColor(widget.priority, 'txtColor'),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () => _showEditModal(context),
                icon: Icon(
                  Icons.more_vert,
                  color: _cardTxtColor(widget.priority, 'txtColor'),
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
                color: _cardTxtColor(widget.priority, 'txtColor'),
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
            // padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
            decoration: BoxDecoration(
              color: _cardTxtColor(widget.priority, 'tagColor'),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                widget.priority,
                style: TextStyle(
                  color: _cardTxtColor(widget.priority, 'tagTxt'),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
