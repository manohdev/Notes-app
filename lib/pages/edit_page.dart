import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';


class AddEditNotePage extends StatefulWidget {
  
  final Note? note;
  const AddEditNotePage({super.key, this.note});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {

  final _formKey = GlobalKey<FormState>();
  late bool isImp;
  late int number;
  late String title;
  late String description;
  
  @override
  void initState() {
    super.initState();

    isImp = widget.note?.isImp ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(actions: [buildButton()]),
    );
  }

  buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal:12),
      child: ElevatedButton(
        child: Text('Save'),
        onPressed: addOrUpdateNote,
        // style: ElevatedButton.styleFrom(
        //   onPrimary: Colors.white,
        //   primary: isFormValid ? null : Colors.grey.shade700,
        // ),
      )
    );
  }
  void addOrUpdateNote() async {
    
  }
}