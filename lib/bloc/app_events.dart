import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable {
  List<Object> get props => [];

}

class Create extends NoteEvent {
  final String title;
  final String description;

  Create(this.title, this.description);
}

class GetData extends NoteEvent {
  GetData();
}