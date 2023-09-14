import 'package:flutter/material.dart';

class EditingPage extends StatelessWidget {
  final Function(String, String) addNewItem;
  String title1;
  String content2;
  EditingPage(
      {Key? key,
      required this.title1,
      required this.content2,
      required this.addNewItem});

  final TextEditingController titleEditor = TextEditingController();
  final TextEditingController contentEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleEditor.text = title1;
    contentEditor.text = content2;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Notes',
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
              initialValue: titleEditor.text,
              readOnly: false,
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
              initialValue: contentEditor.text,
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
