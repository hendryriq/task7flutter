import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_7/response/res_note.dart';
import 'package:task_7/style/app_style.dart';

class NoteDetailScreen extends StatefulWidget {
  NoteDetailScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  TextEditingController? titleController, contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.doc["note_title"]);
    contentController = TextEditingController(text: widget.doc["note_content"]);
  }

  @override
  void dispose() {
    updateNote();
    titleController?.dispose();
    contentController?.dispose();
    super.dispose();
  }

  Future<void> updateNote() async {
    try {
      await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.doc.id)
          .set({
        "note_title": titleController?.text,
        "note_content": contentController?.text,
        // Add other fields as needed
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating document: $e");
      // Handle the error, e.g., show a message to the user
    }
  }

  Future<void> deleteNote() async {
    try {
      print("Deleting note: ${widget.doc.id}");

      // Print details of the document to be deleted
      print("Document details: ${widget.doc.data()}");

      final DocumentReference noteRef =
      FirebaseFirestore.instance.collection('Notes').doc(widget.doc.id);

      // Fetch the existing document data for debugging purposes
      final DocumentSnapshot existingDocument = await noteRef.get();
      print("Existing document data: ${existingDocument.data()}");

      // Delete the document
      await noteRef.delete();

      print("Note deleted successfully");
      // Optionally, navigate back after deletion
      Navigator.pop(context);
    } catch (e) {
      print("Error deleting document: $e");
      // Handle the error, e.g., show a message to the user
    }
  }



  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteNote();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                style: AppStyle.mainTitle,
                maxLines: null,
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
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(border: InputBorder.none),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: AppStyle.mainContent,
                autofocus: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
