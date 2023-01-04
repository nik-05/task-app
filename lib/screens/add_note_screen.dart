import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/bloc/app_blocs.dart';

import '../bloc/app_events.dart';

class AddNoteScreen extends StatefulWidget {
  final BuildContext homeContext;

  const AddNoteScreen({Key? key, required this.homeContext}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  saveNote() {
    String x = titleController.text.trim();
    String y = descriptionController.text.trim();

    if (x.isNotEmpty && y.isNotEmpty) {
      BlocProvider.of<NoteBloc>(widget.homeContext).add(
        Create(x, y),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add notes'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: GoogleFonts.lora(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration.collapsed(
                hintText: 'Title',
                hintStyle: GoogleFonts.lora(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: descriptionController,
              minLines: 5,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.lato(
                color: const Color(0xffF2F2F2),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration.collapsed(
                hintText: 'Your notes here...',
                hintStyle: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.done),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
          backgroundColor: const Color(0xff7885FF),
          minimumSize: const Size(110, 50),
        ),
        onPressed: saveNote,
        label: const Text('Save'),
      ),
    );
  }
}
