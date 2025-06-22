import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/news_screen/widgets/error_retry_widget.dart';
import 'package:news/screens/news_screen/widgets/news_card.dart';
import '../../../blocs/news_bloc/news_bloc.dart';
import '../../constants/route_names.dart';
import '../../theme/app_colors.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatelessWidget {
  static const routeName = RouteNames.home;

  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Latest News',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is NewsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsError) {
              return ErrorRetryWidget(
                message: state.message,
                onRetry: () => context.read<NewsBloc>().add(FetchNewsEvent()),
              );
            } else if (state is NewsLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NewsBloc>().add(FetchNewsEvent());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.separated(
                  itemCount: state.articles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return NewsCard(
                      article: article,
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            NewsDetailScreen.routeName,
                            arguments: article,
                          ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink(); // Fallback
          },
        ),
      ),
    );
  }
}
