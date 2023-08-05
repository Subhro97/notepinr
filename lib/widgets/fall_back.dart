import 'package:flutter/material.dart';

class FallBack extends StatelessWidget {
  const FallBack({
    super.key,
    required this.isMainScreen,
  });

  final bool isMainScreen;

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isMainScreen ? 'no notes added' : 'no checked notes',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.w700,
              color: !theme
                  ? Color(0xD91F1F1F).withOpacity(0.2)
                  : Color.fromRGBO(250, 250, 250, 0.3),
            ),
          ),
          if (isMainScreen)
            Text(
              'Tap + to create a new note',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Oxygen',
                color: !theme
                    ? Color(0xFF424242).withOpacity(0.3)
                    : Color.fromRGBO(250, 250, 250, 0.3),
              ),
            ),
        ],
      ),
    );
  }
}
