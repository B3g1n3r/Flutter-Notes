import 'package:flutter/material.dart';
import 'package:notes/new_notes.dart';


class EditingPage extends StatelessWidget {
  final List<CardItem> cardlist;
  final Function(String, String) addNewItem; // Function to add a new item

  EditingPage({super.key, required this.cardlist, required this.addNewItem});

  final TextEditingController titleEditor = TextEditingController();
  final TextEditingController contentEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final String title = titleEditor.text;
              final String content = contentEditor.text;

              if (title.isNotEmpty && content.isNotEmpty) {
                // Call the addNewItem function with title and content
                addNewItem(title, content);
                showSnackBar(context, 'Saved');
                Navigator.pop(context);
              } else {
                showSnackBar(context, 'Please fill the contents');
              }
            },
            icon: const Icon(Icons.save_alt_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: titleEditor,
              decoration: const InputDecoration(
                hintText: '  Enter the title',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Times new Roman',
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 900,
              child: TextFormField(
                controller: contentEditor,
                decoration: const InputDecoration(
                  hintText: '  Content',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Times new Roman',
                  ),
                ),
                maxLines: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to show a snackbar message
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
