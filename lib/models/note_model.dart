class Note {
  final String title;
  final String description;
  final bool isTrashed;

  Note({
    required this.title,
    required this.description,
    required this.isTrashed,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      description: map['description'],
      isTrashed: map['isTrashed'],
    );
  }
}
