import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepinr/provider/notes_provider.dart';

import 'package:notepinr/widgets/note_card.dart';
import 'package:notepinr/widgets/search_bar_custom.dart';

class SearchNote extends ConsumerStatefulWidget {
  const SearchNote({super.key});

  @override
  ConsumerState<SearchNote> createState() => _SearchNoteState();
}

class _SearchNoteState extends ConsumerState<SearchNote> {
  var _notesList = []; // To store the list of notes of type unchecked from DB
  var _searchedList =
      []; // To store the list of notes which has been typed in the search bar

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(notesProvider); //Getting the state set proider List

    if (notes.isNotEmpty) {
      //Filtering the List as per checked status;
      _notesList = (notes[0]["unCheckedList"] as List).isNotEmpty
          ? (notes[0]["unCheckedList"] as List)
          : [];
    }

    // This method is used to normalize text by removing special characters in texts.
    String _removeSpecialCharacters(String text) {
      final regex = RegExp(r"[^\w\s]");
      return text.replaceAll(regex, '');
    }

    // This method is called every time the value in the search box is changed
    void searchHandler(String value) {
      setState(() {
        if (value.trim() == '') {
          _searchedList = [];
        } else {
          _searchedList = _notesList.where((note) {
            final normalizedTitle = _removeSpecialCharacters(note['title']);
            final normalizedDescription =
                _removeSpecialCharacters(note['description']);
            final normalizedQuery = _removeSpecialCharacters(value);

            return normalizedTitle
                    .toLowerCase()
                    .contains(normalizedQuery.toLowerCase().trim()) ||
                normalizedDescription
                    .toLowerCase()
                    .contains(normalizedQuery.toLowerCase().trim());
          }).toList();
        }
      });
    }

    bool theme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: !theme ? Colors.white : Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(right: 16.0, left: 0.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Expanded(
                    child: SearchBarCustom(
                      isReadOnly: false,
                      onChange: searchHandler,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // width: double.infinity,
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  itemCount: _searchedList.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      key: ValueKey('cont-$index-search'),
                      padding: index != (_searchedList.length - 1)
                          ? const EdgeInsets.only(bottom: 16)
                          : const EdgeInsets.only(bottom: 0),
                      child: NoteCard(
                        key: ValueKey(_searchedList[index]['id'] as int),
                        id: _searchedList[index]['id'] as int,
                        priority: _searchedList[index]['priority'] as String,
                        title: _searchedList[index]['title'] as String,
                        text: _searchedList[index]['description'] as String,
                        date: _searchedList[index]['date'],
                        time: _searchedList[index]['time'],
                        noteType: _searchedList[index]['noteType'],
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
