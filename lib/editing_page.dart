import 'package:flutter/material.dart';

class EditingPage extends StatelessWidget {
  const EditingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Add'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Title',
                  style: TextStyle(fontSize: 20, fontFamily: 'Times new Roman'),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Enter the title',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Times new Roman')),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Title',
                  style: TextStyle(fontSize: 20, fontFamily: 'Times new Roman'),
                ),
                SizedBox(
                  height: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Enter the title',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Times new Roman')),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 8,
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text('Save'))
              ],
            ),
          )),
    );
  }
}
