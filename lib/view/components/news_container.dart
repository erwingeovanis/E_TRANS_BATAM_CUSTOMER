import 'package:e_trans/data/models/news.dart';
import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({Key? key, this.news}) : super(key: key);
  final News? news;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        child: Column(
          children: [
            Expanded(child: Image.network(news!.imageUrl)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                news!.headline!,
                style: Theme.of(context).textTheme.headline5,
              )
            ])
          ],
        ),
      ),
    );
  }
}
