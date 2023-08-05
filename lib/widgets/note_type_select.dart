import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import 'package:notepinr/utils/colors.dart';

import 'package:notepinr/screens/add_checklist.dart';
import 'package:notepinr/screens/add_note.dart';

class NoteTypeSelect extends ConsumerStatefulWidget {
  final BuildContext refContext;
  final void Function() getNotes;

  const NoteTypeSelect(
      {super.key, required this.refContext, required this.getNotes});

  @override
  ConsumerState<NoteTypeSelect> createState() => _NoteTypeSelectState();
}

class _NoteTypeSelectState extends ConsumerState<NoteTypeSelect> {
  void _addNotesHandler() {
    Navigator.of(context).pop();

    Navigator.push(
      widget.refContext,
      PageTransition(
        curve: Curves.linear,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 100),
        reverseDuration: Duration(milliseconds: 100),
        child: const AddNote(),
      ),
    ).then((value) => widget.getNotes());
  }

  void _addChecklistHandler() {
    Navigator.of(context).pop();

    Navigator.push(
      widget.refContext,
      PageTransition(
        curve: Curves.linear,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 100),
        reverseDuration: Duration(milliseconds: 100),
        child: const AddChecklist(),
      ),
    ).then((value) => widget.getNotes());
  }

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: !theme
            ? ColorsLightTheme.backgroundColor
            : const Color.fromRGBO(36, 36, 36, 1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _addNotesHandler,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 40.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: !theme
                                ? const Color.fromRGBO(235, 242, 245, 1)
                                : const Color.fromRGBO(50, 50, 50, 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Image.asset(
                                  'assets/icons/notes.png',
                                  fit: BoxFit.contain,
                                  width: 40.0,
                                  height: 40.0,
                                  color: !theme
                                      ? const Color.fromRGBO(36, 36, 36, 1)
                                      : Color.fromRGBO(250, 250, 250, 0.8),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Note",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _addChecklistHandler,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 40.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: !theme
                                ? const Color.fromRGBO(235, 242, 245, 1)
                                : const Color.fromRGBO(50, 50, 50, 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/to-do_list.png',
                                color: !theme
                                    ? const Color.fromRGBO(36, 36, 36, 1)
                                    : Color.fromRGBO(250, 250, 250, 0.8),
                                fit: BoxFit.contain,
                                width: 40.0,
                                height: 40.0,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "To-do List",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
