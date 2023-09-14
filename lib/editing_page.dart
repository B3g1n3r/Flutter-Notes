import 'package:flutter/material.dart';
import 'package:notes/new_notes.dart';
import 'package:notes/editingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

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
  //ignore
  _MainScreenState createState() => _MainScreenState();
}

enum SampleItem { one, two }

class _MainScreenState extends State<MainScreen> {
  static List<CardItem> cardList = [];

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

  Future<bool?> confirmDelete(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this card'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void saveCardList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> cardListJson = cardList.map((e) => e.toJson()).toList();
    await sharedPreferences.setStringList('cardlist', cardListJson);
  }

  void deleteCard(CardItem cardItem) {
    setState(() {
      cardList.remove(cardItem);
    });
    saveCardList();
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
              icon: const Icon(
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
            return StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              padding: const EdgeInsets.all(4),
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                final cardItem = cardList[index];
                return Dismissible(
                  key: Key(cardItem.title),
                  onDismissed: (direction) {
                    confirmDelete(context).then((value) {
                      if (value == true) {
                        deleteCard(cardItem);
                      } else {
                        setState(() {});
                      }
                    });
                  },
                  direction: DismissDirection.startToEnd,
                  child: InkWell(
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        title: Text(cardItem.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(cardItem.content,
                            maxLines: 6, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return const StaggeredTile.fit(1);
              },
            );
          } else {
            return const Center(
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
