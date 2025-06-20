import 'package:flutter/material.dart';
import '../../models/news_model.dart';
import '../../utils/date_formatter.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = '/details';
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'news-image-${article.title}',
                child: SizedBox(
                  height: size.height * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),

                    child: Image.network(
                      article.urlToImage,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.fill,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            height: 250,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.broken_image),
                            ),
                          ),
                    ),
                  ),
                ),
              ),

              Text(
                article.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                maxLines: 3,
              ),
              Text(
                "${article.sourceName} - ${DateFormatter.formatDate(article.publishedAt)}",
              ),
              Divider(),
              Text(article.description),
            ],
          ),
        ),
      ),
    );
  }
}
