import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Note {
  String id;
  String title;
  String description;
  String priority;
  bool pinned;
  String date;
  String time;

  Note({
    required this.title,
    required this.description,
    required this.priority,
    required this.pinned,
    required this.date,
    required this.time,
  }) : id = uuid.v4();
}
