import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:notpin/models/note.dart';
import 'package:notpin/utils/colors.dart';
import 'package:notpin/widgets/filters_buttons.dart';
import 'package:notpin/utils/db_helper.dart';

const uuid = Uuid();

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formKey = GlobalKey<FormState>();

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  var _enteredTitle = '';
  var _enteredDesc = '';

  bool _pinned = false;
  String _priority = 'High';

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  void _resetForm() {
    setState(() {
      _formKey.currentState!.reset();
      _pinned = false;
      _priority = 'High';
      _dateController.text = '';
      _timeController.text = '';
    });
    FocusScope.of(context).unfocus();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission
      _formKey.currentState!.save();

      DBHelper.insert('notes_list', {
        // "id": uuid.v4(),
        "title": _enteredTitle,
        "description": _enteredDesc,
        "priority": _priority,
        "pinned": _pinned == true ? 1 : 0,
        "date": _selectedDate!.toIso8601String(),
        "time": _selectedTime.toString(),
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus text fields when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'add note',
            style: TextStyle(
              color: ColorsLightTheme.txtColor,
            ),
          ),
          titleSpacing: 16,
          centerTitle: false,
          backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
          scrolledUnderElevation: 0,
        ),
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
                    decoration: const InputDecoration(
                      labelText: 'Title',
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
                    decoration: const InputDecoration(
                      labelText: 'Description',
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
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                          ),
                          readOnly: true,
                          controller: _dateController,
                          onTap: _selectDate,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Time',
                          ),
                          readOnly: true,
                          controller: _timeController,
                          onTap: _selectTime,
                        ),
                      ),
                    ],
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
                  Row(
                    children: const [
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
                                      ? const Color.fromRGBO(0, 0, 0, 1)
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
                                    ? const Color.fromRGBO(0, 0, 0, 1)
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
                                      ? const Color.fromRGBO(0, 0, 0, 1)
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
                                    ? const Color.fromRGBO(0, 0, 0, 1)
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
                                      ? const Color.fromRGBO(0, 0, 0, 1)
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
                                    ? const Color.fromRGBO(0, 0, 0, 1)
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
                    onExecute: _submitForm,
                    executeTxt: 'ADD',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
