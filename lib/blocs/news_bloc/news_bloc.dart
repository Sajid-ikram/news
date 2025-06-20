import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/news_model.dart';
import '../../services/news_api_service.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService service;

  NewsBloc(this.service) : super(NewsInitial()) {
    on<FetchNewsEvent>(_onFetchNews);
  }

  Future<void> _onFetchNews(FetchNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final news = await service.fetchNews();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError('Failed to load news'));
    }
  }
}
