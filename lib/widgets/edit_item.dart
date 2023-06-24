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
    bool theme = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        _getIcon(type, value),
        size: 24,
      ),
      iconColor:
          !theme ? Colors.black : const Color.fromRGBO(250, 250, 250, 0.8),
      title: Text(
        _getTitle(type, value),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'Oxygen',
          color: !theme
              ? const Color.fromRGBO(0, 0, 0, 1)
              : const Color.fromRGBO(250, 250, 250, 0.8),
        ),
      ),
      horizontalTitleGap: 8,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      onTap: onTapHandler,
    );
  }
}
