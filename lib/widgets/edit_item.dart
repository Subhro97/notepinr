import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  const EditItem({
    super.key,
    required this.onTapHandler,
    required this.type,
    required this.value,
  });

  final String type;
  final dynamic value;
  final void Function() onTapHandler;

  IconData _getIcon(String type, bool? value) {
    switch (type) {
      case 'pin':
        return value! ? Icons.push_pin : Icons.push_pin_outlined;

      case 'edit':
        return Icons.edit;

      default:
        return Icons.device_hub;
    }
  }

  String _getTitle(String type, bool? value) {
    switch (type) {
      case 'pin':
        return value! ? 'Pinned' : 'Unpinned';

      case 'edit':
        return 'Edit';

      default:
        return 'Notpin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _getIcon(type, value),
        size: 24,
      ),
      iconColor: Colors.black,
      title: Text(
        _getTitle(type, value),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      horizontalTitleGap: -5,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      onTap: onTapHandler,
    );
  }
}
