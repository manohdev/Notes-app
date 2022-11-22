import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/db/notes_database.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/pages/edit_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  
  const NoteDetailPage({super.key, required this.noteId});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    this.note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [editButton(), deleteButton()]),
      body: isLoading 
      ? const Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Text(
                note.title,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat.yMMMd().format(note.createdTime),
                style: const TextStyle(color:Colors.white54),
              ),
              const SizedBox(height: 8),
              Text(
                note.description,
                style: const TextStyle(color: Colors.white70, fontSize: 18)
              )
            ],
          ),
        )
    );
  }

  Widget editButton() {
    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => AddEditNotePage(note: note))));
        refreshNote();
      },
    );
  }

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await NotesDatabase.instance.delete(widget.noteId);
      Navigator.of(context).pop();
    },

  );
}