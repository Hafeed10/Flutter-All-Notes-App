import 'package:hive/hive.dart';
part 'note_model.g.dart';
 // Hive Type Adapter (after generating)

@HiveType(typeId: 0) // Unique typeId for Hive
class NoteModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime dateCreated;

  @HiveField(4)
  final DateTime? dateModified;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    this.dateModified,
  });
}
