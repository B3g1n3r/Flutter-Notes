import 'dart:convert';

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
