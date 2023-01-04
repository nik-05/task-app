class Note {
  final String title;
  final String description;
  final bool isTrashed;

  Note({
    required this.title,
    required this.description,
    required this.isTrashed,
});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      description: json['description'],
      isTrashed: json['isTrashed'],
    );
  }

}