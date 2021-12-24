import 'package:flutter/material.dart';

import '../services/get_news.dart';

class OnlineNews extends StatefulWidget {
  OnlineNews({Key? key}) : super(key: key);

  @override
  State<OnlineNews> createState() => _OnlineNewsState();
}

loadNews() async {
  var currentNews = await getNews();
  // print(currentNews);
  String title = currentNews['data'][3]['title'];
  print(currentNews['data'].length);
}

class _OnlineNewsState extends State<OnlineNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        child: const Text('Get News'),
        onPressed: () {
          setState(() {
            loadNews();
          });
        },
      ),
    ));
  }
}
