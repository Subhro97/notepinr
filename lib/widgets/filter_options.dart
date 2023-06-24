import 'package:flutter/material.dart';

import 'package:notepinr/utils/colors.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({
    super.key,
    required this.filterType,
    required this.onFilter,
  });

  final String? filterType;
  final void Function(String name) onFilter;
  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Filter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Divider(
          color: theme
              ? const Color.fromRGBO(143, 150, 153, 1)
              : const Color.fromRGBO(196, 204, 208, 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pinned Notes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () => onFilter('Pinned'),
                icon: Icon(
                  filterType != 'Pinned'
                      ? Icons.radio_button_unchecked
                      : Icons.radio_button_checked,
                  color: !theme
                      ? ColorsLightTheme.primaryColor
                      : ColorsDarkTheme.primaryColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
