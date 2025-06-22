import 'package:flutter/material.dart';
import '../../../models/news_model.dart';
import '../../../utils/date_formatter.dart';
import '../../constants/route_names.dart';
import '../../theme/app_colors.dart';
import '../../utils/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = RouteNames.details;
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
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
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        article.urlToImage.isNotEmpty
                            ? Image.network(
                              article.urlToImage,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey[200],
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(Icons.broken_image),
                                    ),
                                  ),
                            )
                            : Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              Text(
                article.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.textColor,
                ),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text(
                "${article.sourceName} - ${DateFormatter.formatDate(article.publishedAt)}",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              Divider(height: 25),
              Text(
                article.description,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  launchCustomUrl(context, article.url);
                },
                child: Text(
                  "Read in browser",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
