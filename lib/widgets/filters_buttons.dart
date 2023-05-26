import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onReset,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorsLightTheme.primaryVariantColor,
            foregroundColor: ColorsLightTheme.primaryColor,
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
            backgroundColor: ColorsLightTheme.primaryColor,
            foregroundColor: ColorsLightTheme.primaryTxtColor,
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
