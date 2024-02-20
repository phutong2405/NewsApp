import 'package:flutter/material.dart';
import 'package:newsapplication/models/article.dart';

@immutable
abstract class AppState {
  const AppState();
}

abstract class AppActionState {
  const AppActionState();
}

class AppInitialState implements AppState {
  const AppInitialState();
}

class AppLoaddingState implements AppState {
  const AppLoaddingState();
}

class AppLoaddedState implements AppState {
  final List<Article> data;
  const AppLoaddedState({required this.data});
}

class AppRefreshingState implements AppState {
  const AppRefreshingState();
}
