import 'package:flutter/material.dart';
import 'package:note_app/view/screen_add_note.dart';

class ScreenAllNotes extends StatefulWidget {
  const ScreenAllNotes({super.key});

  @override
  _ScreenAllNotesState createState() => _ScreenAllNotesState();
}

class _ScreenAllNotesState extends State<ScreenAllNotes> {
  List<Map<String, String>> notes = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some dummy notes (optional)
    notes = List.generate(
      5,
      (index) => {
        'id': index.toString(),
        'title': 'Note $index',
        'content': 'This is content for note $index',
      },
    );
  }

  // Method to add or update a note
  void _addOrUpdateNote(Map<String, String> noteData) {
    bool isEdit = notes.any((note) => note['id'] == noteData['id']);
    setState(() {
      if (isEdit) {
        // Update the existing note
        int index = notes.indexWhere((note) => note['id'] == noteData['id']);
        notes[index] = noteData;
      } else {
        // Add new note
        notes.add(noteData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notes'),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
          children: List.generate(
            notes.length,
            (index) => NoteItem(
              id: notes[index]['id']!,
              title: notes[index]['title']!,
              content: notes[index]['content']!,
              onDelete: (id) {
                setState(() {
                  notes.removeWhere((note) => note['id'] == id);
                });
              },
              onEdit: () async {
                // Navigate to edit screen and wait for the result
                Map<String, String>? result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScreenAddNote(
                      type: ActionType.editNote,
                      id: notes[index]['id'],
                      existingTitle: notes[index]['title'],
                      existingContent: notes[index]['content'],
                    ),
                  ),
                );
                if (result != null) {
                  _addOrUpdateNote(result);  // Update note
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navigate to add note screen and wait for the result
          Map<String, String>? result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenAddNote(type: ActionType.addNote),
            ),
          );
          if (result != null) {
            _addOrUpdateNote(result);  // Add new note
          }
        },
        label: const Text('New'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final VoidCallback onEdit;
  final Function(String) onDelete;

  const NoteItem({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onDelete(id),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Text(
              content,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
