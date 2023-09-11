import 'package:flutter/material.dart';

class CardItem {
  final String title;
  final String content;

  CardItem({required this.title, required this.content});
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key, required this.cardItem});

  final CardItem cardItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(cardItem.title),
        subtitle: Text(cardItem.content),
        
      ),
    );
  }
}
