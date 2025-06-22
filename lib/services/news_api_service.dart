import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/news_model.dart';

class NewsService {
  Future<List<NewsArticle>> fetchNews() async {
    String apiKey = dotenv.env['API_KEY'] ?? '';
    final url = AppUrls.topHeadlinesUrl(apiKey: apiKey);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final articles = jsonData['articles'] as List;

      return articles.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
