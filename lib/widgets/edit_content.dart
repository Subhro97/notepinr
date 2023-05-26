import 'package:flutter/material.dart';

import 'package:notpin/utils/colors.dart';

class EditContent extends StatelessWidget {
  const EditContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorsLightTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
      child: Column(
        children: [
          Row(
            children: const <Widget>[
              Icon(
                Icons.edit,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Edit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: const <Widget>[
              Icon(
                Icons.check,
                size: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Mark as Done',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
