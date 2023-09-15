import 'package:flutter/material.dart';

class EditingPage extends StatefulWidget {
  final Function(String, String) updateItem;
  final String title1;
  final String content2;

  EditingPage({
    Key? key,
    required this.title1,
    required this.content2,
    required this.updateItem,
  }) : super(key: key);

  @override
  _EditingPageState createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  TextEditingController titleEditor = TextEditingController();
  TextEditingController contentEditor = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleEditor.text = widget.title1;
    contentEditor.text = widget.content2;
  }

  @override
  void dispose() {
    titleEditor.dispose();
    contentEditor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                widget.updateItem(title, content);
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
