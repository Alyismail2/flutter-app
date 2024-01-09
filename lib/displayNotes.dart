import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'viewNote.dart';
import 'addNote.dart'; // Import your AddNote screen file

class Note {
  final int id;
  final String title;
  final String note;
  final String datePublished;

  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.datePublished,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: int.parse(json['id']),
      title: json['title'],
      note: json['note'],
      datePublished: json['datePublished'],
    );
  }
}

class DisplayNotesScreen extends StatefulWidget {
  @override
  _DisplayNotesScreenState createState() => _DisplayNotesScreenState();
}

class _DisplayNotesScreenState extends State<DisplayNotesScreen> {
  List<Note> notes = [];

  Future<void> _fetchNotes() async {
    final response = await http.get(
      Uri.parse('https://insuppressible-gras.000webhostapp.com/displayNotes.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        notes = (json.decode(response.body) as List)
            .map((data) => Note.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Failed to load notes! Please try again later.');
    }
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(note.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.note),
            Text('Date Published: ${note.datePublished}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _showDeleteConfirmationDialog(note.id);
          },
        ),
      ),
    );
  }

  Future<void> _deleteNote(int id) async {
    final response = await http.post(
      Uri.parse('https://insuppressible-gras.000webhostapp.com/delNote.php'),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      print('Note deleted successfully');
      _fetchNotes();
    } else {
      print('Failed to delete note. ${response.body}');
    }
  }

  Future<void> _showDeleteConfirmationDialog(int id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this note?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteNote(id);
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNoteScreen()), // Assuming your addNote.dart is named AddNoteScreen
              ).then((_) {
                // Refresh the list after adding a note
                _fetchNotes();
              });
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(
        child: Text('No notes yet!'),
      )
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewNoteScreen(
                    title: notes[index].title,
                    note: notes[index].note,
                    datePublished: notes[index].datePublished,
                  ),
                ),
              );
            },
            child: _buildNoteCard(notes[index]),
          );
        },
      ),
    );
  }
}