import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news/blocs/news_bloc/news_bloc.dart';
import 'package:news/models/news_model.dart';
import 'package:news/services/news_api_service.dart';


class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsBloc newsBloc;
  late MockNewsService mockService;

  final mockArticles = [
    NewsArticle(
      title: 'Test Title',
      description: 'Test Description',
      url: 'https://example.com',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: '2024-06-20T12:00:00Z',
      sourceName: 'Mock Source',
    ),
  ];

  setUp(() {
    mockService = MockNewsService();
    newsBloc = NewsBloc(mockService);
  });

  tearDown(() {
    newsBloc.close();
  });

  group('NewsBloc Tests', () {
    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsLoaded] when FetchNewsEvent is added and fetch is successful',
      build: () {
        when(() => mockService.fetchNews())
            .thenAnswer((_) async => mockArticles);
        return newsBloc;
      },
      act: (bloc) => bloc.add(FetchNewsEvent()),
      expect: () => [
        NewsLoading(),
        NewsLoaded(mockArticles),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsError] when FetchNewsEvent throws error',
      build: () {
        when(() => mockService.fetchNews())
            .thenThrow(Exception('API Error'));
        return newsBloc;
      },
      act: (bloc) => bloc.add(FetchNewsEvent()),
      expect: () => [
        NewsLoading(),
        isA<NewsError>(),
      ],
    );
  });
}
