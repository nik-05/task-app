import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/models/note_model.dart';

class Repository {
  final noteReference = FirebaseFirestore.instance.collection('notes');

  Future<void> create(
      {required String title, required String description}) async {
    try {
      await noteReference.add(
          {'title': title, 'description': description, 'isTrashed': false});
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Note>> get() async {
    List<Note> noteList = [];

    try {
      final notes = await noteReference.where('isTrashed', isEqualTo: false).get();

      notes.docs.forEach((element) {
        return noteList.add(Note.fromJson(element.data()));
      });

      return noteList;
    } on FirebaseException catch (e) {
      return noteList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
