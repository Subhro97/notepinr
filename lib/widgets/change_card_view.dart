import 'package:flutter/material.dart';
import 'package:notepinr/provider/card_mode_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notepinr/utils/colors.dart';

class ChangeCardView extends ConsumerStatefulWidget {
  const ChangeCardView({super.key});

  @override
  ConsumerState<ChangeCardView> createState() => _ChangeCardViewState();
}

class _ChangeCardViewState extends ConsumerState<ChangeCardView> {
  String? viewType;
  String? filterType;

  @override
  void initState() {
    super.initState();

    // Whenever the sort modal opens, the selected sort & filter options are set to be shown
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        viewType = prefs.getString('cardView');
      });
    });
  }

  // applying the selected options & updating the global state
  Future<void> selectCardView(BuildContext ctx, String cardView) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cardView', cardView);

    ref.read(cardModeProvider.notifier).setCardMode(
        cardView); // Setting the card Mode to be available globally

    Navigator.pop(ctx);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16.0),
            child: Text(
              'Select View',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.view_list),
                iconColor: !theme
                    ? Colors.black
                    : const Color.fromRGBO(250, 250, 250, 0.8),
                title: Text(
                  'List View',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Oxygen',
                    color: !theme
                        ? const Color.fromRGBO(0, 0, 0, 1)
                        : const Color.fromRGBO(250, 250, 250, 0.8),
                  ),
                ),
                horizontalTitleGap: 8,
                trailing: Icon(
                  (viewType == 'list') ? Icons.check : null,
                  color: !theme
                      ? Color.fromRGBO(59, 130, 246, 1)
                      : Color.fromRGBO(97, 150, 234, 1),
                ),
                onTap: () => selectCardView(context, 'list'),
                dense: true,
                contentPadding: const EdgeInsets.only(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  top: 0,
                ),
              ),
              ListTile(
                leading: Icon(Icons.border_all_rounded),
                iconColor: !theme
                    ? Colors.black
                    : const Color.fromRGBO(250, 250, 250, 0.8),
                title: Text(
                  'Grid View',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Oxygen',
                    color: !theme
                        ? const Color.fromRGBO(0, 0, 0, 1)
                        : const Color.fromRGBO(250, 250, 250, 0.8),
                  ),
                ),
                horizontalTitleGap: 8,
                trailing: Icon(
                  (viewType == 'grid') ? Icons.check : null,
                  color: !theme
                      ? Color.fromRGBO(59, 130, 246, 1)
                      : Color.fromRGBO(97, 150, 234, 1),
                ),
                onTap: () => selectCardView(context, 'grid'),
                dense: true,
                contentPadding: const EdgeInsets.only(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  top: 0,
                ),
              ),
              ListTile(
                leading: Icon(Icons.view_stream_sharp),
                iconColor: !theme
                    ? Colors.black
                    : const Color.fromRGBO(250, 250, 250, 0.8),
                title: Text(
                  'Detail View',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Oxygen',
                    color: !theme
                        ? const Color.fromRGBO(0, 0, 0, 1)
                        : const Color.fromRGBO(250, 250, 250, 0.8),
                  ),
                ),
                horizontalTitleGap: 8,
                trailing: Icon(
                  (viewType == 'detail' || viewType == null)
                      ? Icons.check
                      : null,
                  color: !theme
                      ? Color.fromRGBO(59, 130, 246, 1)
                      : Color.fromRGBO(97, 150, 234, 1),
                ),
                onTap: () => selectCardView(context, 'detail'),
                dense: true,
                contentPadding: const EdgeInsets.only(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  top: 0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
