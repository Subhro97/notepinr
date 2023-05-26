import "package:flutter/material.dart";

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('PLANS PAGE')),
    );
  }
}
