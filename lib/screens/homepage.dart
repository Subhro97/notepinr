import 'package:flutter/material.dart';

import 'package:notpin/widgets/note_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.notes});
  final dynamic notes;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: widget.notes.length,
        itemBuilder: ((context, index) {
          return Container(
            key: ValueKey('cont-$index'),
            padding: index != (widget.notes.length - 1)
                ? const EdgeInsets.only(bottom: 16)
                : const EdgeInsets.only(bottom: 0),
            child: NoteCard(
              key: ValueKey(widget.notes[index]['id']),
              id: widget.notes[index]['id'],
              priority: widget.notes[index]['priority'],
              title: widget.notes[index]['title'],
              text: widget.notes[index]['description'],
            ),
          );
        }),
      ),
    );
  }
}
