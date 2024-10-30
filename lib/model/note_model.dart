class Note {
  int? id;
  String date;  // Store date as a string (formatted as yyyy-MM-dd)
  String content;

  Note({
    this.id,
    required this.date,
    required this.content,
  });

  // Convert a Note into a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'content': content,
    };
  }

  // Create a Note from a Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      date: map['date'],
      content: map['content'],
    );
  }
}
