import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/bloc/app_blocs.dart';
import 'package:note_app/bloc/app_events.dart';
import 'package:note_app/bloc/app_states.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/screens/view_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NoteBloc>(context).add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: const Text('All Notes'),
          centerTitle: false,
        ),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoaded) {
            List<Note> data = state.myNotes;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: const Color(0xff1A191E),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewNote(
                              title: data[index].title,
                              description: data[index].description,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        data[index].title,
                        style: GoogleFonts.lora(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        data[index].description,
                        maxLines: 2,
                        style: GoogleFonts.lato(
                          color: const Color(0xffF2F2F2),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is NoteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff7885FF),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context2) => AddNoteScreen(homeContext: context),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
