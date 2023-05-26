import 'package:flutter/material.dart';

import 'package:notpin/widgets/sort_options.dart';
import 'package:notpin/widgets/filter_options.dart';
import 'package:notpin/widgets/filters_buttons.dart';
import 'package:notpin/utils/colors.dart';

class SortFilterContent extends StatefulWidget {
  const SortFilterContent({super.key});

  @override
  State<SortFilterContent> createState() => _SortFilterContentState();
}

class _SortFilterContentState extends State<SortFilterContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsLightTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [SortOptions(), Divider(), FilterOptions()],
          ),
          FiltersButtons(
            onReset: () {},
            onExecute: (() {}),
          ),
        ],
      ),
    );
  }
}
