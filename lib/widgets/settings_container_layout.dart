import 'package:flutter/material.dart';

class SettingsContainerLayout extends StatelessWidget {
  const SettingsContainerLayout({
    super.key,
    required this.child,
    required this.heading,
  });

  final Widget child;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: heading == 'About' ? 16 : 0,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(235, 242, 245, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 3,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(59, 130, 246, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 8.0, bottom: 8.0, right: 16),
                  child: child,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
