import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/bloc/app_blocs.dart';
import 'package:note_app/bloc/app_states.dart';
import 'package:note_app/firebase_options.dart';
import 'package:note_app/palette.dart';
import 'package:note_app/repository/repository.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Palette.backgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: false,
            backgroundColor: Palette.backgroundColor,
          )),
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => NoteBloc(
        repository: RepositoryProvider.of<Repository>(context),
      ),
      child: Scaffold(
        key: scaffoldKey,
        body: BlocListener<NoteBloc, NoteState>(
          listener: (context, state) {
            if (state is NoteAdded) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Note Added')));
            }
          },
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteAdding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoteError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return const HomeScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
