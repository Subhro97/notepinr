import "package:flutter/material.dart";

import 'package:notepinr/widgets/note_card.dart';
import 'package:notepinr/widgets/fall_back.dart';

class CheckedPage extends StatefulWidget {
  const CheckedPage({super.key, required this.checkedNotes});
  final dynamic checkedNotes;

  @override
  State<CheckedPage> createState() => _CheckedPageState();
}

class _CheckedPageState extends State<CheckedPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.checkedNotes.length == 0) {
      return FallBack(isMainScreen: false);
    }
    return Container(
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: widget.checkedNotes.length,
        itemBuilder: ((context, index) {
          return Container(
            key: ValueKey('cont-$index'),
            padding: index != (widget.checkedNotes.length - 1)
                ? const EdgeInsets.only(bottom: 16)
                : const EdgeInsets.only(bottom: 0),
            child: NoteCard(
              key: ValueKey(widget.checkedNotes[index]['id']),
              id: widget.checkedNotes[index]['id'],
              priority: widget.checkedNotes[index]['priority'],
              title: widget.checkedNotes[index]['title'],
              text: widget.checkedNotes[index]['description'],
              date: widget.checkedNotes[index]['date'],
              time: widget.checkedNotes[index]['time'],
              isCheckedPage: true,
            ),
          );
        }),
      ),
    );
  }
}
