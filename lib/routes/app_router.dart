import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../screens/news_screen/news_list_screen.dart';
import '../screens/news_screen/news_detail_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const NewsListScreen());
      case '/details':
        final args = settings.arguments;
        if (args is NewsArticle) {
          return MaterialPageRoute(
            builder: (_) => NewsDetailScreen(article: args),
            settings: settings,
          );
        }
        return _errorRoute('Invalid arguments for /details route');
      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text(message)),
          ),
    );
  }
}
