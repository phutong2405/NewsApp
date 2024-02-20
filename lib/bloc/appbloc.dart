import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/models/article.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final List<Article> bookmarkList = [];
  AppBloc() : super(const AppInitialState()) {
    on<AppInitialEvent>(appInitialEvent);
    on<AppRefreshEvent>(appRefreshEvent);

    ////Function Clicked
    on<BookmarkClicked>(bookmarkClicked);
  }

  FutureOr<void> appInitialEvent(
      AppInitialEvent event, Emitter<AppState> emit) async {
    emit(const AppLoaddingState());

    await Future.delayed(
      const Duration(milliseconds: 500),
      () => emit(AppLoaddedState(data: data30)),
    );
  }

  FutureOr<void> appRefreshEvent(
      AppRefreshEvent event, Emitter<AppState> emit) async {
    emit(const AppRefreshingState());
    // emit(const AppLoaddingState());

    await Future.delayed(
      const Duration(milliseconds: 500),
      () => emit(AppLoaddedState(data: data30)),
    );
  }

  FutureOr<void> bookmarkClicked(
      BookmarkClicked event, Emitter<AppState> emit) {
    bookmarkList.add(event.article);
    print(bookmarkList);
  }
}
