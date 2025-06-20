part of 'news_bloc.dart';

abstract class NewsEvent {
  @override
  List<Object> get props => [];
}

class FetchNewsEvent extends NewsEvent {}
