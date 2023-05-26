import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

class BottomSheetContent extends StatefulWidget {
  final Widget child;
  final double height;

  const BottomSheetContent({
    super.key,
    required this.child,
    required this.height,
  });

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.height,
      builder: (context, scrollController) => Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: ColorsLightTheme.txtColor,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Color.fromRGBO(250, 250, 250, 1),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
    ;
  }
}
