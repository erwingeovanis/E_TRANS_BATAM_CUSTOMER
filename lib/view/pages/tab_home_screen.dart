import 'package:e_trans/data/models/news.dart';
import 'package:e_trans/provider/main_provider.dart';
import 'package:e_trans/view/components/news_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_trans/utils/context_utils.dart';
import 'package:e_trans/view/screens/news_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Container(
        color: Colors.transparent,
        child: Consumer<MainProvider>(
          builder: (context, value, child) {
            List<News> news = value.news;
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => context.pushTo(NewsScreen(
                    news: news[index],
                  )),
                  child: NewsContainer(
                    news: news[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
