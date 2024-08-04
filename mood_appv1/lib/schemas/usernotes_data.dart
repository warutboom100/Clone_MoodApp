class NotesResponse {
  final String username;
  final List<Note> notesData;

  NotesResponse({required this.username, required this.notesData});

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    return NotesResponse(
      username: json['username'],
      notesData: (json['notes_data'] as List)
          .map((noteJson) => Note.fromJson(noteJson))
          .toList(),
    );
  }
}

class Note {
  final String time;
  final List<String> icon;
  final String note;

  Note({required this.time, required this.icon, required this.note});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      time: json['time'],
      icon: List<String>.from(json['icon']),
      note: json['note'],
    );
  }
}
