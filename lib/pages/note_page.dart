import 'package:flutter/material.dart';
import 'package:notes_app/widget/note_card_widget.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:notes_app/db/notes_database.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/pages/edit_page.dart';
import 'package:notes_app/pages/detail_page.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
//import 'package:notes_app/widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  
  late List<Note> notes;
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    refreshNotes();
    
  }

  Future refreshNotes() async {
    setState(()=> isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState((() => isLoading = false));
  }
  
  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 24)
        ),
        actions: [Icon(Icons.search), SizedBox(width: 12,)]
      ),
      body: Center(
        child: isLoading 
              ? CircularProgressIndicator() 
              : notes.isEmpty ? Text('No Notes') : buildNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> AddEditNotePage())
          );
          refreshNotes();
        },
      ),
    );
  }
  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemCount: notes.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    itemBuilder: (context, index) {
      final note = notes[index];
      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(noteId: note.id!),
            )
          );
          refreshNotes();

          
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
    
    

  );
  
}