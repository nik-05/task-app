import 'package:equatable/equatable.dart';

import '../models/note_model.dart';

abstract class NoteState extends Equatable {}

class InitialState extends NoteState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class NoteAdding extends NoteState {
  @override
  List<Object?> get props => [];
}

class NoteAdded extends NoteState{
  @override
  List<Object?> get props =>[];

}

class NoteError extends NoteState {
  final String error;

  NoteError(this.error);
  @override
  List<Object?> get props => [error];
}

class NoteLoading extends NoteState {
  @override
  List<Object?> get props =>[];
}

class NoteLoaded extends NoteState {
  List<Note> myNotes;
  NoteLoaded(this.myNotes);

  @override
  List<Object?> get props =>[myNotes];
}