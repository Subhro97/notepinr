import "package:flutter/material.dart";

import 'package:notepinr/widgets/note_card.dart';
import 'package:notepinr/widgets/fall_back.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:notepinr/provider/card_mode_provider.dart';

class CheckedPage extends ConsumerStatefulWidget {
  const CheckedPage({super.key, required this.checkedNotes});
  final dynamic checkedNotes;

  @override
  ConsumerState<CheckedPage> createState() => _CheckedPageState();
}

class _CheckedPageState extends ConsumerState<CheckedPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.checkedNotes.length == 0) {
      return FallBack(isMainScreen: false);
    }
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
              itemCount: widget.checkedNotes.length,
              itemBuilder: ((context, index) {
                return Container(
                  key: ValueKey('cont-$index'),
                  child: NoteCard(
                    key: ValueKey(widget.checkedNotes[index]['id']),
                    id: widget.checkedNotes[index]['id'],
                    priority: widget.checkedNotes[index]['priority'],
                    title: widget.checkedNotes[index]['title'],
                    text: widget.checkedNotes[index]['description'],
                    date: widget.checkedNotes[index]['date'],
                    time: widget.checkedNotes[index]['time'],
                    noteType: widget.checkedNotes[index]['noteType'],
                    isCheckedPage: true,
                  ),
                );
              }),
            )
          : Container(
              width: double.infinity,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      noteType: widget.checkedNotes[index]['noteType'],
                      isCheckedPage: true,
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
