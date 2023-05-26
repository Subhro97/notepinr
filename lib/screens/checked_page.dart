import "package:flutter/material.dart";

class CheckedPage extends StatefulWidget {
  const CheckedPage({super.key});

  @override
  State<CheckedPage> createState() => _CheckedPageState();
}

class _CheckedPageState extends State<CheckedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('CHECKED PAGE')),
    );
  }
}
