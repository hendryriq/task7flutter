import 'package:cloud_firestore/cloud_firestore.dart';

class ResNote {
   String noteTitle;
   String creationDate;
   String noteContent;
   int colorId;

  ResNote({
    required this.noteTitle,
    required this.creationDate,
    required this.noteContent,
    required this.colorId,
  });

  // Convert the object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'note_title': noteTitle,
      'creation_date': creationDate,
      'note_content': noteContent,
      'color_id': colorId,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'noteTitle': noteTitle,
      'creationDate': creationDate,
      'noteContent': noteContent,
      'colorId': colorId,
    };
  }

  factory ResNote.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ResNote(
      noteTitle: data['note_title'],
      creationDate: data['creation_date'],
      noteContent: data['note_content'],
      colorId: data['color_id'],
    );
  }

  static ResNote fromMap(Map<String, dynamic> map) {
    return ResNote(
      noteTitle: map['note_title'],
      creationDate: map['creation_date'],
      noteContent: map['note_content'],
      colorId: map['color_id'],
    );
  }
}
