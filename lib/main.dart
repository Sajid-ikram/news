import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/news_bloc/news_bloc.dart';
import 'models/news_model.dart';
import 'services/news_api_service.dart';
import 'screens/news_list_screen.dart';
import 'screens/news_detail_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(NewsService())..add(FetchNewsEvent()),
        )
      ],
      child: MaterialApp(
        title: 'News Pulse',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const NewsListScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const NewsListScreen());
            case '/details':
              final article = settings.arguments as NewsArticle;
              return MaterialPageRoute(
                builder: (_) => NewsDetailScreen(article: article),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}