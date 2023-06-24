import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:notepinr/screens/search_note.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({
    super.key,
    this.isReadOnly = true,
    this.onChange,
  });

  final bool isReadOnly;
  final void Function(String val)? onChange;

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(5.0), // Set your desired border radius here
      ),
      child: Container(
        height: 48, // Adjust the height as per your requirement
        child: TextField(
          readOnly: isReadOnly,
          autofocus: !isReadOnly,
          onTap: isReadOnly
              ? () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const SearchNote(),
                    ),
                  )
              : null,
          onChanged: !isReadOnly ? ((value) => onChange!(value)) : null,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(
              color: !theme
                  ? const Color.fromRGBO(194, 216, 252, 1)
                  : const Color.fromRGBO(250, 250, 250, 0.8).withOpacity(0.3),
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontFamily: 'Oxygen',
            ),
            prefixIcon: Icon(
              Icons.search,
              color: !theme
                  ? const Color.fromRGBO(194, 216, 252, 1)
                  : const Color.fromRGBO(250, 250, 250, 0.8).withOpacity(0.3),
            ),
            filled: true,
            fillColor: !theme
                ? const Color.fromRGBO(235, 242, 245, 1)
                : const Color.fromRGBO(36, 36, 36, 1),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Oxygen',
          ),
        ),
      ),
    );
  }
}
