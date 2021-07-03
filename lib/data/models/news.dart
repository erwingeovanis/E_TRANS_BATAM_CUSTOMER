// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

import 'package:e_trans/data/service/network_service.dart';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    this.content,
    this.date,
    this.headline,
    this.idNews,
    this.image,
    this.publisher,
  });

  String? content;
  String? date;
  String? headline;
  int? idNews;
  String? image;
  String? publisher;
  String get imageUrl => NetworkService.BASEURL + "/news/image/" + image!;

  factory News.fromJson(Map<String, dynamic> json) => News(
        content: json["content"],
        date: json["date"],
        headline: json["headline"],
        idNews: json["id_news"],
        image: json["image"],
        publisher: json["publisher"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "date": date,
        "headline": headline,
        "id_news": idNews,
        "image": image,
        "publisher": publisher,
      };
}
