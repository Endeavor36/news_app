import 'package:flutter/material.dart';

import '../models/news.dart';
import '../services/get_news.dart';
import './online_news.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    loadNews();
  }

  List<News> allNews = [];

  int currentIndex = 0;

  loadNews() async {
    var currentNews = await getNews();
    for (int i = 0; i < currentNews['data'].length; i++) {
      News news = News(
        id: currentNews['data'][i]['id'] ?? 'not provided',
        title: currentNews['data'][i]['title'] ?? 'not provided',
        summary: currentNews['data'][i]['summary'] ?? 'not provided',
        link: currentNews['data'][i]['link'] ?? 'not provided',
        published: currentNews['data'][i]['published'] ?? 'not provided',
      );

      allNews.add(news);
    }

    // String title = currentNews['data'][3]['title'];
    // print(currentNews['data'].length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add_link_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnlineNews()),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allNews.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.favorite),
                  color: allNews[index].isFavorite == true
                      ? Colors.red
                      : Colors.grey,
                  onPressed: () {
                    setState(() {
                      if (allNews[index].isFavorite == false) {
                        allNews[index].isFavorite = true;
                      } else {
                        allNews[index].isFavorite = false;
                      }
                    });
                  },
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allNews[index].title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      allNews[index].summary,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      allNews[index].published,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                horizontalTitleGap: 10,
                minVerticalPadding: 15,
              ),
            ),
          );
        },
      ),
    );
  }
}
