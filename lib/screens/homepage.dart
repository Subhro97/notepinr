import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:notepinr/provider/card_mode_provider.dart';

import 'package:notepinr/widgets/note_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.notes});
  final dynamic notes;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final noteCardMode = ref.watch(cardModeProvider); // To obtain the card mode

    return Container(
      width: double.infinity,
      child: noteCardMode == 'grid'
          ? MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              itemCount: widget.notes.length,
              itemBuilder: ((context, index) {
                return Container(
                  key: ValueKey('cont-$index'),
                  // padding: index != (widget.notes.length - 1)
                  //     ? const EdgeInsets.only(bottom: 16)
                  //     : const EdgeInsets.only(bottom: 0),
                  child: NoteCard(
                    key: ValueKey(widget.notes[index]['id']),
                    id: widget.notes[index]['id'],
                    priority: widget.notes[index]['priority'],
                    title: widget.notes[index]['title'],
                    text: widget.notes[index]['description'],
                    date: widget.notes[index]['date'],
                    time: widget.notes[index]['time'],
                    noteType: widget.notes[index]['noteType'],
                  ),
                );
              }),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
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
                    date: widget.notes[index]['date'],
                    time: widget.notes[index]['time'],
                    noteType: widget.notes[index]['noteType'],
                  ),
                );
              }),
            ),
    );
  }
}
