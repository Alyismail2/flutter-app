import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  void _handleAddNote() async {
    String title = _titleController.text.trim();
    String note = _noteController.text.trim();

    final response = await http.post(
      Uri.parse('https://insuppressible-gras.000webhostapp.com/addNote.php'),
      body: {'title': title, 'note': note},
    );

    if (response.statusCode == 200) {
      print('Note added successfully');
      Navigator.pushReplacementNamed(context, '/displayNotes');
    } else {
      print('Failed to add note. ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleAddNote,
              child: Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}