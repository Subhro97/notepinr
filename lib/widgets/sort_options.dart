import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

class SortOptions extends StatelessWidget {
  const SortOptions({super.key, required this.sortType, required this.onSort});

  final String? sortType;
  final void Function(String name) onSort;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Sort',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Priority Level',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  onSort('Priority');
                },
                icon: Icon(
                  sortType == 'Priority' || sortType == null
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: ColorsLightTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Added: First To Last',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  onSort('FirstToLast');
                },
                icon: Icon(
                  sortType == 'FirstToLast'
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: ColorsLightTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Added: Last To First',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  onSort('LastToFirst');
                },
                icon: Icon(
                  sortType == 'LastToFirst'
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: ColorsLightTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
