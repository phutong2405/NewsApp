import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/models/article.dart';

@immutable
abstract class AppState {
  const AppState();
}

abstract class AppLoginState implements AppState {
  const AppLoginState();
}

abstract class TranslateState implements AppState {
  const TranslateState();
}

/// OVERALL APP STATE

class AppInitialState implements AppState {
  const AppInitialState();
}

class AppLoaddingState implements AppState {
  const AppLoaddingState();
}

class AppLoaddedState implements AppState {
  final List<Article>? data;
  const AppLoaddedState({required this.data});
}

class AppSnackBarState implements AppState {
  final String content;
  const AppSnackBarState(this.content);
}

class AppDarkModeState implements AppState {
  const AppDarkModeState();
}

class AppLoadingEventState implements AppState {
  const AppLoadingEventState();
}

///DETAIL OVERALL STATE

class EventSuccessfulState implements AppState {
  final String content;
  const EventSuccessfulState(this.content);
}

class EventFailState implements AppState {
  final FirebaseAuthException error;
  const EventFailState(this.error);
}

class AppRefreshingState implements AppState {
  const AppRefreshingState();
}

///FEATURE STATE

class BookmarkState implements AppState {
  final List<Article>? data;
  const BookmarkState({required this.data});
}

class TranslateClickedState implements TranslateState {
  final bool isTranslate;
  final Map<String, String> translateItemList;
  const TranslateClickedState(this.isTranslate, this.translateItemList);
}

class LoggedState implements AppLoginState {
  final bool isLogged;
  LoggedState({required this.isLogged});
}

class AppOutState implements AppState {
  const AppOutState();
}
