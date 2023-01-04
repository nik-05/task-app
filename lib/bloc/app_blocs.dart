import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/bloc/app_states.dart';
import 'package:note_app/repository/repository.dart';

import 'app_events.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Repository repository;

  NoteBloc({required this.repository}) : super(InitialState()) {
    on<Create>((event, emit) async {
      emit(NoteAdding());
      await Future.delayed(const Duration(seconds: 1, milliseconds: 1));
      try {
        await repository.create(
            title: event.title, description: event.description);
        emit(NoteAdded());
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<GetData>((event, emit) async {
      emit(NoteLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final notes = await repository.get();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });
  }
}
