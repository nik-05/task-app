import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/repository/repository.dart';

class ViewNote extends StatelessWidget {
  final String title;
  final String description;
  const ViewNote({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Repository().deleteNote(title: title);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.lora(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 20),
              Text(description, style: GoogleFonts.lato(
                fontSize: 18,
                color: const Color(0xffF2F2F2),
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
