import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notepinr/utils/colors.dart';
import 'package:notepinr/widgets/filters_buttons.dart';
import 'package:notepinr/utils/db_helper.dart';
import 'package:notepinr/provider/notes_provider.dart';
import 'package:notepinr/utils/notification_api.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({
    super.key,
    this.noteID,
    this.type = 'add',
    this.title = '',
    this.description = '',
    this.pinStatus = false,
    this.priority = 'High',
    this.date = '',
    this.time = '',
  });

  final int? noteID;
  final String type;
  final String title;
  final String description;
  final bool pinStatus;
  final String priority;
  final String date;
  final String time;

  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final _formKey = GlobalKey<FormState>();

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  late TextEditingController _titleController;
  late TextEditingController _desController;

  var _enteredTitle = '';
  var _enteredDesc = '';

  bool _pinned = false;
  String _priority = 'High';

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.title);
    _desController = TextEditingController(text: widget.description);
    _enteredDesc = widget.description;
    _pinned = widget.pinStatus;
    _priority = widget.priority;
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _titleController.text = '';
      _desController.text = '';
      _pinned = false;
      _priority = 'High';
    });
    FocusScope.of(context).unfocus();
  }

  void _submitForm(ctx) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // To ececute the save methods of the text form fields.
      DateTime _now = DateTime.now();
      Map<String, Object?> data = {
        "title": _enteredTitle.trim(),
        "description": _enteredDesc.trim(),
        "priority": _priority,
        "pinned": _pinned == true ? 1 : 0,
        "date": DateFormat('dd-MM-yyyy').format(_now).toString(),
        "time":
            '${_now.hour < 10 ? '0${_now.hour}' : _now.hour}:${_now.minute < 10 ? '0${_now.minute}' : _now.minute}',
        "checked": 0,
      };

      int? pinnedID;
      try {
        if (widget.noteID != null) {
          DBHelper.updateNote('notepinr_notes_list', widget.noteID!, data);
          NotificationAPI.removePinnedNotifications(widget
              .noteID!); // Remove the previous notification with the same ID.
        } else {
          pinnedID = await DBHelper.insert('notepinr_notes_list', data);
        }

        // If pinned option is selected in form, then pin notification
        if (_pinned) {
          NotificationAPI.showNotification(
            widget.noteID == null ? pinnedID! : widget.noteID!,
            _enteredTitle,
            _enteredDesc,
            _priority,
          );
        }

        ref
            .read(notesProvider.notifier)
            .setNotesFromDB(); // To update the local state to the vale of the Database.
      } catch (error) {
        print(error);
      }

      Navigator.pop(ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        // Unfocus text fields when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.type.trim() == 'edit' ? 'edit note' : 'add note',
            style: TextStyle(
              color: !theme
                  ? ColorsLightTheme.txtColor
                  : const Color.fromRGBO(250, 250, 250, 0.87),
            ),
          ),
          iconTheme: IconThemeData(
            color: !theme
                ? Colors.black
                : const Color.fromRGBO(250, 250, 250, 0.87),
          ),
          toolbarHeight: 64,
          titleSpacing: 0,
          centerTitle: false,
          backgroundColor: !theme ? Colors.white : Colors.black,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: !theme ? Colors.white : Colors.black,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsetsDirectional.only(top: 8, start: 16, end: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: const TextStyle(
                        fontFamily: 'Oxygen',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: !theme
                              ? Colors.black45
                              : const Color.fromRGBO(250, 250, 250, 0.87),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Oxygen',
                    ),
                    focusNode: _titleFocusNode,
                    maxLength: 50,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) {
                      setState(() {
                        // Reset the validation error when typing
                        _formKey.currentState!.validate();
                      });
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _enteredTitle = newValue!,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _desController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: const TextStyle(
                        fontFamily: 'Oxygen',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: !theme
                              ? Colors.black45
                              : const Color.fromRGBO(250, 250, 250, 0.87),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Oxygen',
                    ),
                    focusNode: _descriptionFocusNode,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    onChanged: (_) {
                      setState(() {
                        // Reset the validation error when typing
                        _formKey.currentState!.validate();
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _enteredDesc = newValue!,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text('Pinned :'),
                      IconButton(
                        iconSize: 32,
                        icon: _pinned
                            ? const Icon(Icons.push_pin)
                            : const Icon(Icons.push_pin_outlined),
                        onPressed: () {
                          setState(() {
                            _pinned = !_pinned;
                          });
                        },
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Row(
                    children: [
                      Icon(Icons.info_outlined),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'If you tap it, your note will be pinned to your notification bar',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text('Priority :'),
                      const SizedBox(width: 16.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _priority = 'High';
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(251, 113, 133, 1),
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: _priority == 'High'
                                      ? !theme
                                          ? const Color.fromRGBO(0, 0, 0, 1)
                                          : const Color.fromRGBO(
                                              250, 250, 250, 0.87)
                                      : Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'High',
                              style: TextStyle(
                                color: _priority == 'High'
                                    ? !theme
                                        ? const Color.fromRGBO(0, 0, 0, 1)
                                        : const Color.fromRGBO(
                                            250, 250, 250, 0.87)
                                    : const Color.fromRGBO(128, 128, 128, 1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _priority = 'Medium';
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(253, 186, 116, 1),
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: _priority == 'Medium'
                                      ? !theme
                                          ? const Color.fromRGBO(0, 0, 0, 1)
                                          : const Color.fromRGBO(
                                              250, 250, 250, 0.87)
                                      : Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Medium',
                              style: TextStyle(
                                color: _priority == 'Medium'
                                    ? !theme
                                        ? const Color.fromRGBO(0, 0, 0, 1)
                                        : const Color.fromRGBO(
                                            250, 250, 250, 0.87)
                                    : const Color.fromRGBO(128, 128, 128, 1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _priority = 'Low';
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(74, 222, 128, 1),
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: _priority == 'Low'
                                      ? !theme
                                          ? const Color.fromRGBO(0, 0, 0, 1)
                                          : const Color.fromRGBO(
                                              250, 250, 250, 0.87)
                                      : Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Low',
                              style: TextStyle(
                                color: _priority == 'Low'
                                    ? !theme
                                        ? const Color.fromRGBO(0, 0, 0, 1)
                                        : const Color.fromRGBO(
                                            250, 250, 250, 0.87)
                                    : const Color.fromRGBO(128, 128, 128, 1),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48.0),
                  FiltersButtons(
                    onReset: _resetForm,
                    onExecute: (() => _submitForm(context)),
                    executeTxt: widget.type.trim() == 'edit' ? 'UPDATE' : 'ADD',
                  ),
                  const SizedBox(height: 48.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
