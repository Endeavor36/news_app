import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/news.dart';

Future<List<News>> getNews() async {
  String newsUrl = 'https://api.first.org/data/v1/news';
  final response = await http.get(Uri.parse(newsUrl));

  var responseData = json.decode(response.body);

  List<News> news = [];
  for (var singleNews in responseData) {
    News n = News(
      id: singleNews['data']['id'],
      link: singleNews['data']['link'],
      published: singleNews['data']['published'],
      summary: singleNews['data']['summary'],
      title: singleNews['data']['title'],
    );
    news.add(n);
  }
  return news;
}
