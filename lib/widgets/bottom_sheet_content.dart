import 'package:flutter/material.dart';

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
    bool theme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: widget.height,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: !theme
                  ? Color.fromRGBO(50, 50, 50, 1)
                  : const Color.fromRGBO(25, 25, 25, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, color: Colors.white70),
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
  }
}
