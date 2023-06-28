import 'package:flutter/material.dart';

class FaqList extends StatefulWidget {
  const FaqList({super.key});

  @override
  State<FaqList> createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  final List<Map<String, String>> _faqItems = [
    {
      'id': '1',
      'title':
          'Why is the Notifications removed when the app is in the background, minimized, or swiped from recent apps?',
      'content':
          'Some phones have the power saving option selected by default which might prevent the app from running in the background. Try to disable this option from your phone\'s Settings to resolve the issue. If the issue still persists, you can contact me by the Report Bug option in the Settings tab.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontFamily: 'Oxygen',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ExpansionPanelList.radio(
            elevation: 1,
            children: _faqItems
                .map<ExpansionPanelRadio>(
                  (item) => ExpansionPanelRadio(
                    value: item['id']!,
                    backgroundColor: !theme
                        ? Colors.white
                        : const Color.fromRGBO(36, 36, 36, 1),
                    headerBuilder: ((context, isExpanded) {
                      return ListTile(
                        title: Text(
                          item['title']!,
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            height: 1.3,
                            color: !theme
                                ? Colors.black
                                : const Color.fromRGBO(250, 250, 250, 0.7),
                          ),
                        ),
                      );
                    }),
                    body: ListTile(
                      title: Text(
                        item['content']!,
                        style: TextStyle(
                          fontFamily: 'Oxygen',
                          height: 1.3,
                          color: !theme
                              ? Colors.black
                              : const Color.fromRGBO(250, 250, 250, 0.7),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
