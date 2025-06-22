import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'blocs/news_bloc/news_bloc.dart';
import 'services/news_api_service.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
import 'constants/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (_) => NewsBloc(NewsService())..add(FetchNewsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'News',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.home,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
