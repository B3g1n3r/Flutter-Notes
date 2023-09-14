import 'package:flutter/material.dart';
import 'package:notes/new_notes.dart';

class SavingPage extends StatelessWidget {
  final List<CardItem> cardlist;
  final Function(String, String) addNewItem;

  SavingPage({Key? key, required this.cardlist, required this.addNewItem});

  final TextEditingController titleEditor = TextEditingController();
  final TextEditingController contentEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final String title = titleEditor.text;
              final String content = contentEditor.text;

              if (title.isNotEmpty && content.isNotEmpty) {
                addNewItem(title, content);
                showSnackBar(context, 'Note Saved');
                Navigator.pop(context);
              } else {
                showSnackBar(context, 'Please fill in both fields');
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: titleEditor,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: contentEditor,
              style: const TextStyle(fontSize: 18),
              maxLines: 11,
              decoration: InputDecoration(
                hintText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(15),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
