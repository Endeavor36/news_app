import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleCard extends ConsumerWidget {
  final News article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    final dateTime = DateTime.now().difference(article.publishedAt);
    final articleDate = DateTime.now().subtract(dateTime);
    return InkWell(
      onTap: () async {
        if (!await launchUrl(
          Uri.parse(article.url),
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch');
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return SizedBox(
                    height: size.height * 0.24,
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: primaryColor.withOpacity(0.05),
                      highlightColor: primaryColor.withOpacity(0.2),
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: primaryColor.withOpacity(0.05),
                  height: size.height * 0.24,
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error),
                      Text('Could not load image'),
                    ],
                  ),
                ),
                article.imageUrl,
                fit: BoxFit.cover,
                height: size.height * 0.24,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              article.title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            // const SizedBox(height: 6.0),
            Row(
              children: [
                Text(
                  '${article.source} | ${timeago.format(articleDate, locale: 'en_short')}',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    Share.share(article.url);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
