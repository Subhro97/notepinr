import 'package:flutter/material.dart';

import 'package:notepinr/utils/colors.dart';

class FiltersButtons extends StatelessWidget {
  const FiltersButtons({
    super.key,
    required this.onReset,
    required this.onExecute,
    this.executeTxt = 'APPLY',
  });

  final void Function() onReset;
  final void Function() onExecute;
  final String executeTxt;

  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onReset,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: !theme
                ? ColorsLightTheme.primaryVariantColor
                : const Color.fromARGB(204, 66, 66, 66),
            foregroundColor: !theme
                ? ColorsLightTheme.primaryColor
                : const Color.fromRGBO(250, 250, 250, 0.87),
            minimumSize: const Size(126, 40),
            alignment: Alignment.center,
            textStyle: const TextStyle(
              fontSize: 14,
              letterSpacing: 0.1,
            ),
          ),
          child: const Text('RESET'),
        ),
        const SizedBox(
          width: 19,
        ),
        ElevatedButton(
          onPressed: onExecute,
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: !theme
                ? ColorsLightTheme.primaryColor
                : ColorsDarkTheme.primaryColor,
            foregroundColor: !theme
                ? ColorsLightTheme.primaryTxtColor
                : ColorsDarkTheme.primaryTxtColor,
            minimumSize: const Size(126, 40),
            alignment: Alignment.center,
            textStyle: const TextStyle(
              fontSize: 14,
              letterSpacing: 0.1,
            ),
          ),
          child: Text(executeTxt),
        ),
      ],
    );
  }
}
