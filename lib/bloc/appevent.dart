import 'package:flutter/material.dart';
import 'package:newsapplication/models/article.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class AppInitialEvent implements AppEvent {
  const AppInitialEvent();
}

class AppRefreshEvent implements AppEvent {
  const AppRefreshEvent();
}

class BookmarkClicked implements AppEvent {
  final Article article;
  const BookmarkClicked({required this.article});
}
