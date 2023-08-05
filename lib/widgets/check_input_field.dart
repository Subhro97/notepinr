import 'package:flutter/material.dart';

import 'package:notepinr/models/input_data.dart';

class CheckInputField extends StatefulWidget {
  final ValueKey key;
  final InputData inputData;
  final bool isLastItem;
  final TextEditingController? textEditingController;
  final Function(String) onChanged;
  final Function(bool?) onCheckboxChanged;
  final void Function() onCrossIconClicked;

  CheckInputField({
    required this.key,
    required this.inputData,
    required this.onChanged,
    required this.onCheckboxChanged,
    required this.onCrossIconClicked,
    required this.isLastItem,
    this.textEditingController,
  });

  @override
  State<CheckInputField> createState() => _CheckInputFieldState();
}

class _CheckInputFieldState extends State<CheckInputField> {
  FocusNode? _focusNode;
  late TextEditingController _valueController;

  // If the Check note is the last one, then it sud retain Focus/cursor
  @override
  void initState() {
    super.initState();
    if (widget.isLastItem) {
      _focusNode = FocusNode();
      _focusNode!.requestFocus();
    } else {
      _focusNode = null;
    }
    _valueController = TextEditingController(text: widget.inputData.text);
  }

  // To dispose the focus node for rest check inputs
  @override
  void dispose() {
    super.dispose();
    if (_focusNode != null) {
      _focusNode!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      key: widget.key,
      horizontalTitleGap: 8,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      leading: Checkbox(
        value: widget.inputData.isChecked,
        onChanged: widget.onCheckboxChanged,
      ),
      iconColor:
          !theme ? Colors.black : const Color.fromRGBO(250, 250, 250, 0.8),
      title: TextFormField(
        focusNode: _focusNode,
        controller: _valueController,
        maxLines: null,
        readOnly: false,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: "Enter to-do",
          labelStyle: const TextStyle(
            fontFamily: 'Oxygen',
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontFamily: 'Oxygen',
          decoration: widget.inputData.isChecked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          decorationThickness: 2.5,
        ),
        onTap: () {
          if (widget.inputData.isChecked) {
            widget.onCheckboxChanged(false);
          }
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          widget.onCrossIconClicked();
        },
      ),
    );
  }
}
