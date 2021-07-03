import 'package:e_trans/data/models/news.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key, required this.news}) : super(key: key);
  final News news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.headline ?? ""),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        children: [
          Container(child: Image.network(news.imageUrl)),
          Row(
            children: [
              Text(((news.publisher ?? "").isEmpty
                      ? "Anonim"
                      : news.publisher!) +
                  " - ${news.date}")
            ],
          ),
          Text(news.content ?? "no content"),
        ],
      ),
    );
  }
}
