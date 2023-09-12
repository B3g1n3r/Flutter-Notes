import 'package:flutter/material.dart';
import 'package:notes/editing_page.dart';
import 'package:notes/new_notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static List<CardItem> cardList = [
    CardItem(title: 'Card 1', content: 'Content 1'),
    CardItem(title: 'Card 2', content: 'Content 2'),
    CardItem(title: 'Card 3', content: 'Content 3'),
  ];

  void addNewItem(String title, String content) {
    CardItem newItem = CardItem(title: title, content: content);
    setState(
      () {
        cardList.add(newItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return CardItemWidget(cardItem: cardList[index]);
        },
        itemCount: cardList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditingPage(
                cardlist: [],
                addNewItem: addNewItem,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
