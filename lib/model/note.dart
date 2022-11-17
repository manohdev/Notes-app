final String tableNotes = 'notes';


class NoteFields {
  static final List<String> values = [
    // add all fields
    id, isImp, number, title, description, time
  ];

  static final String id = '_id';
  static final String isImp = 'number';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isImp;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImp,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime
  });

  Note copy({
            int? id,
            bool? isImp,
            int? number,
            String? title,
            String? description,
            DateTime? createdTime
          }) => Note(
                      id: id ?? this.id,
                      isImp: isImp ?? this.isImp,
                      number: number ?? this.number,
                      title: title?? this.title,
                      description: description?? this.description,
                      createdTime: createdTime?? this.createdTime

                    );
  // static Note fromJson(Map<String, Object?> json) =>

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.title: title,
    NoteFields.isImp: isImp ? 1:0,
    NoteFields.number: number,
    NoteFields.description: description,
    NoteFields.time: createdTime.toIso8601String()
  };


}