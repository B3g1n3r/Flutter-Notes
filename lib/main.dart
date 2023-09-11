import 'package:flutter/material.dart';
import 'package:notes/editing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CardItem> cardList = [
      CardItem(title: 'Card 1', content: 'Content 1'),
      CardItem(title: 'Card 2', content: 'Content 2'),
      CardItem(title: 'Card 3', content: 'Content 3'),
      CardItem(title: 'Card 4', content: 'Content 4'),
    ];

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
            MaterialPageRoute(builder: (context) => const EditingPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardItem {
  final String title;
  final String content;

  CardItem({required this.title, required this.content});
}

class CardItemWidget extends StatelessWidget {
  final CardItem cardItem;

  const CardItemWidget({Key? key, required this.cardItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(cardItem.title),
        subtitle: Text(cardItem.content),
      ),
    );
  }
}
