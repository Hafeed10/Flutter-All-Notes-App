import 'package:flutter/material.dart';
import 'package:note_app/view/screen_add_note.dart';

class ScreenAllNotes extends StatelessWidget {
  const ScreenAllNotes({super.key});

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
            10,
            (index) => NoteItem(
              id: index.toString(),
              title: 'Note $index',
              content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet ullamcorper tortor. In sit amet enim mi. Sed sed magna sit amet lacus volutpat lacinia consequat eget risus. Maecenas pharetra libero at placerat imperdiet. Fusce nisl magna, euismod nec pulvinar sollicitudin, fermentum eu nibh. Fusce semper pulvinar convallis. Nullam vel diam velit. Aenean ut erat risus. Morbi aliquam elementum molestie. Nulla facilisi. Mauris sodales urna quis massa varius luctus',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenAddNote(type: ActionType.addNote),
            ),
          );
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

  const NoteItem({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenAddNote(
              type: ActionType.editNote,
              id: id,
            ),
          ),
        );
      },
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
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    
                    // Add delete functionality here
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Text(
              content,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Assuming ScreenAddNote and ActionType are defined elsewhere
