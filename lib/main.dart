import 'package:flutter/material.dart';
import 'package:notes/editing_page.dart';
import 'package:notes/new_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  //ignore
  _MainScreenState createState() => _MainScreenState();
}

enum SampleItem { one, two }

class _MainScreenState extends State<MainScreen> {
  static List<CardItem> cardList = [
    CardItem(title: 'Card 1', content: 'Content 1'),
    CardItem(title: 'Card 2', content: 'Content 2'),
    CardItem(title: 'Card 3', content: 'Content 3'),
  ];

  @override
  void initState() {
    super.initState();
    loadCardList();
  }

  void addNewItem(String title, String content) {
    CardItem newItem = CardItem(title: title, content: content);
    setState(
      () {
        cardList.add(newItem);
        saveCardList();
      },
    );
  }

  Future<void> loadCardList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? cardListJson = sharedPreferences.getStringList('cardlist');
    if (cardListJson != null) {
      cardList = cardListJson.map((e) => CardItem.fromJson(e)).toList();
    }
  }

  void saveCardList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> cardListJson = cardList.map((e) => e.toJson()).toList();
    await sharedPreferences.setStringList('cardlist', cardListJson);
  }

  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          PopupMenuButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              initialValue: selectedMenu,
              onSelected: (SampleItem item) {
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<SampleItem>>[
                  const PopupMenuItem(
                    value: SampleItem.one,
                    child: Text('data'),
                  ),
                  const PopupMenuItem(
                    value: SampleItem.two,
                    child: Text('data'),
                  ),
                ];
              }),
        ],
      ),
      body: FutureBuilder(
        future: loadCardList(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return CardItemWidget(cardItem: cardList[index]);
              },
              itemCount: cardList.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
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
