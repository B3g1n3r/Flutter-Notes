import 'dart:convert';

import 'package:flutter/material.dart';

class CardItem {
  final String title;
  final String content;

  CardItem({required this.title, required this.content});

  String toJson() {
    final Map<String, dynamic> data = {'title': title, 'content': content};
    return jsonEncode(data);
  }

  factory CardItem.fromJson(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return CardItem(title: data['title'], content: data['content']);
  }
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key, required this.cardItem});

  final CardItem cardItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cardItem.title),
      onDismissed: (direction) {
        
      },
      direction: DismissDirection.startToEnd,
      child: InkWell(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            title: Text(cardItem.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(cardItem.content,
                maxLines: 6, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
