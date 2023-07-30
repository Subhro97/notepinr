import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subTitle;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            size: 28,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: !theme
                      ? const Color.fromRGBO(0, 0, 0, 1)
                      : const Color.fromRGBO(250, 250, 250, 0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  // fontFamily: 'Oxygen',
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                subTitle,
                style: TextStyle(
                  color: !theme
                      ? const Color.fromRGBO(66, 66, 66, 1)
                      : const Color.fromRGBO(250, 250, 250, 0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // fontFamily: 'Oxygen',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
