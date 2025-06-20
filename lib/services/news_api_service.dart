import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=cd1bba85145a45098d7d90415b51a651'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final articles = jsonData['articles'] as List;

      return articles.map((e) => NewsArticle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
