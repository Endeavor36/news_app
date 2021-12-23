import 'package:flutter/material.dart';

import '../models/news.dart';
// import '../services/get_news.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  final List<News> newsList = [
    News(
      id: 40813,
      title: "Meeting in person at the FIRST Oslo Technical Colloquium",
      summary:
          "Last month, I was honored to be one of the planners and participants of the FIRST Technical Colloquium (TC) in Norway. Organized by FIRST members, the event was held just outside of Oslo at the Telenor Expo, Telenor headquarters in Fornebu.\n",
      link:
          "https://www.first.org/blog/20211129-meeting_person_first_oslo_technical_colloquium",
      published: "Tue, 07 Dec 2021 17:00:00 GMT",
    ),
    News(
      id: 40813,
      title: "Meeting in person at the FIRST Oslo Technical Colloquium",
      summary:
          "Last month, I was honored to be one of the planners and participants of the FIRST Technical Colloquium (TC) in Norway. Organized by FIRST members, the event was held just outside of Oslo at the Telenor Expo, Telenor headquarters in Fornebu.\n",
      link:
          "https://www.first.org/blog/20211129-meeting_person_first_oslo_technical_colloquium",
      published: "Tue, 07 Dec 2021 17:00:00 GMT",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: newsList.length,
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
                  onPressed: () {},
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsList[index].title,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      newsList[index].summary,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      newsList[index].published,
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
