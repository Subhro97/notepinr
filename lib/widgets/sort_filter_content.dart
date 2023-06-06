import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notpin/provider/notes_provider.dart';

import 'package:notpin/widgets/sort_options.dart';
import 'package:notpin/widgets/filter_options.dart';
import 'package:notpin/widgets/filters_buttons.dart';

import 'package:notpin/utils/colors.dart';

class SortFilterContent extends ConsumerStatefulWidget {
  const SortFilterContent({super.key});

  @override
  ConsumerState<SortFilterContent> createState() => _SortFilterContentState();
}

class _SortFilterContentState extends ConsumerState<SortFilterContent> {
  String? sortType;
  String? filterType;

  @override
  void initState() {
    super.initState();

    // Whenever the sort modal opens, the selected sort & filter options are set to be shown
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sortType = prefs.getString('sort');
        filterType = prefs.getString('filter');
      });
    });
  }

  // Selecting the Sort option & shwoing it on the UI
  void selectSortOption(String value) {
    setState(() {
      sortType = value;
    });
  }

  // Selecting the Filter option & shwoing it on the UI
  void selectFilterOption(String value) {
    setState(() {
      filterType = value;
    });
  }

  // Reseting the sort & filter to default states
  void resetOptions() {
    setState(() {
      sortType = 'Priority';
      filterType = '';
    });
  }

  // applying the selected options & updating the global state
  Future<void> applySortNFilters(BuildContext ctx) async {
    if (sortType != null && filterType != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('sort', sortType!);
      prefs.setString('filter', filterType!);

      ref.watch(notesProvider.notifier).setNotesFromDB();

      Navigator.pop(ctx);
    }
  }

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
            children: [
              SortOptions(
                sortType: sortType,
                onSort: selectSortOption,
              ),
              const Divider(),
              FilterOptions(
                filterType: filterType,
                onFilter: selectFilterOption,
              )
            ],
          ),
          FiltersButtons(
            onReset: resetOptions,
            onExecute: () => applySortNFilters(context),
          ),
        ],
      ),
    );
  }
}
