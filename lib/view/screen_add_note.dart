import 'package:flutter/material.dart';

enum ActionType {
  addNote,
  editNote,
}

class ScreenAddNote extends StatefulWidget {
  final ActionType type;
  final String? id;
  final String? existingTitle;
  final String? existingContent;

  ScreenAddNote({
    required this.type,
    this.id,
    this.existingTitle,
    this.existingContent,
    super.key,
  });

  @override
  _ScreenAddNoteState createState() => _ScreenAddNoteState();
}

class _ScreenAddNoteState extends State<ScreenAddNote> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.type == ActionType.editNote) {
      _titleController.text = widget.existingTitle ?? "";
      _contentController.text = widget.existingContent ?? "";
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Save button widget
  Widget get saveButton => TextButton.icon(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final String title = _titleController.text;
            final String content = _contentController.text;

            // Create note data to pass back
            Map<String, String> noteData = {
              'id': widget.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
              'title': title,
              'content': content,
            };

            Navigator.of(context).pop(noteData);  // Pass note data back to ScreenAllNotes
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == ActionType.addNote
            ? "Add Note"
            : "Edit Note: ${widget.id}"),
        actions: [saveButton],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  maxLines: 4,
                  maxLength: 100,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Content',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
