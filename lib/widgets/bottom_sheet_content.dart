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
    return DraggableScrollableSheet(
      initialChildSize: widget.height,
      builder: (context, scrollController) => Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 18, 18, 18),
              borderRadius: BorderRadius.all(
                Radius.circular(40),
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
