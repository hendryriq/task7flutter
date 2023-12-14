import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_7/response/res_note.dart';
import 'package:task_7/style/app_style.dart';

class NoteDetailScreen extends StatefulWidget {
  // ResNote? doc;
  NoteDetailScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  TextEditingController? title, content;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // title = TextEditingController(text: widget.doc?.noteTitle);
    // content = TextEditingController(text: widget.doc?.noteContent);
  }

  /*Future<void> updateNote(ResNote note) async {
    note.noteTitle = title?.text;
    note.noteContent = content?.text;
    note.userId = widget.data?.userId;
    await database
        .ref()
        .child("note")
        .child(note.key!)
        .set(note.toJson())
        .then((_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // controller: _titleController,
              style: AppStyle.mainTitle,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 4,),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            SizedBox(height: 28),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            )

          ],
        ),
      ),
    );
  }
}
