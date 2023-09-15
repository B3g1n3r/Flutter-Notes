import 'package:flutter/material.dart';
import 'package:notes/editingpage.dart';
import 'package:notes/savingpage.dart';
import 'package:notes/new_notes.dart';
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
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CardItem> cardList = [];
  List<CardItem> filteredCardList = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCardList();
  }

  void addNewItem(String title, String content) {
    CardItem newItem = CardItem(title: title, content: content);
    setState(() {
      cardList.add(newItem);
      saveCardList();
      if (!isSearching) {
        filteredCardList.add(newItem);
      }
    });
  }

  Future<void> loadCardList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? cardListJson = sharedPreferences.getStringList('cardlist');
    if (cardListJson != null) {
      cardList = cardListJson.map((e) => CardItem.fromJson(e)).toList();
      if (!isSearching) {
        setState(() {
          filteredCardList = List.from(cardList);
        });
      }
    }
    cardList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  Future<bool?> confirmDelete(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this card?'),
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
      if (!isSearching) {
        // Update filteredCardList if not in search mode
        filteredCardList.remove(cardItem);
      }
    });
    saveCardList();
  }

  void updateItem(String oldTitle, String newTitle, String newContent) {
    int index = cardList.indexWhere((item) => item.title == oldTitle);
    if (index != -1) {
      setState(() {
        cardList[index].title = newTitle;
        cardList[index].content = newContent;
        if (!isSearching) {
          // Update filteredCardList if not in search mode
          int filteredIndex =
              filteredCardList.indexWhere((item) => item.title == oldTitle);
          if (filteredIndex != -1) {
            filteredCardList[filteredIndex].title = newTitle;
            filteredCardList[filteredIndex].content = newContent;
          }
        }
        saveCardList();
      });
    }
  }

  void filterResult(String query) {
    setState(() {
      if (query.isNotEmpty) {
        isSearching = true;
        filteredCardList = cardList.where((element) {
          return element.title.toLowerCase().contains(query.toLowerCase()) ||
              element.content.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        isSearching = false;
        filteredCardList = List.from(cardList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                onChanged: filterResult,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              )
            : const Text(
                'Notes',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  filterResult('');
                }
              });
            },
            icon: isSearching
                ? const Icon(Icons.cancel, color: Colors.black)
                : const Icon(Icons.search, color: Colors.black),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        padding: const EdgeInsets.all(4),
        itemCount: filteredCardList.length,
        itemBuilder: (context, index) {
          final cardItem = filteredCardList[index];
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditingPage(
                      title1: cardItem.title,
                      content2: cardItem.content,
                      updateItem: (newTitle, newContent) {
                        updateItem(cardItem.title, newTitle, newContent);
                      },
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: Text(
                    cardItem.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    cardItem.content,
                    style: const TextStyle(fontSize: 17),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return const StaggeredTile.fit(1);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SavingPage(
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
