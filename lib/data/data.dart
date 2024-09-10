import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/model/note_model.dart';

const NOTE_DB_NAME = 'note_db';

class NotesDb {
  NotesDb._internal();
  static final NotesDb instance = NotesDb._internal();

  factory NotesDb() {
    return instance;
  }

  Future<void> deleteNote(String noteId) async {
    final _noteBox = await Hive.openBox<NoteModel>(NOTE_DB_NAME);
    await _noteBox.delete(noteId);  // Delete note by ID
    // Optionally refresh UI or notify listeners here if needed
  }

}
