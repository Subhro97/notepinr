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
        return Icons.edit_outlined;

      case 'delete':
        return Icons.delete_outline;

      case 'cancel':
        return Icons.close_rounded;

      case 'clone':
        return Icons.content_copy;

      case 'done':
        return Icons.check;

      case 'share':
        return Icons.share_outlined;

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

      case 'delete':
        return 'Delete';

      case 'cancel':
        return 'Cancel';

      case 'clone':
        return 'Clone';

      case 'done':
        return value! ? 'Mark as Undone' : 'Mark as done';

      case 'share':
        return 'Share';

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
