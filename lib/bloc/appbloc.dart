import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/bloc/blocbrain.dart';
import 'package:newsapplication/data/localdata.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/preferencepage/cupertinoswitch.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late List<Article> data;
  final List<Article> bookmarkList = [];
  final LocalSettingDataService localSettingDataService =
      LocalSettingDataService.instance;

  AppBloc() : super(const AppInitialState()) {
    on<AppInitialEvent>(appInitialEvent);
    on<AppRefreshEvent>(appRefreshEvent);

    ////Function Clicked
    on<BookmarkClicked>(bookmarkClicked);

    ///Settings Data Update
    on<AppSettingChangedSwitchEvent>(appSettingChangedSwitchEvent);
    on<AppSettingChangedPickerEvent>(appSettingChangedPickerEvent);
    on<AppSettingChangedLanguageEvent>(appSettingChangedLanguageEvent);
  }

  ///MAIN EVENT

  FutureOr<void> appInitialEvent(
      AppInitialEvent event, Emitter<AppState> emit) async {
    await localSettingDataService.inital();
    emit(const AppLoaddingState());
    data = data30;
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => emit(AppLoaddedState(data: data)),
    );
  }

  FutureOr<void> appRefreshEvent(
      AppRefreshEvent event, Emitter<AppState> emit) async {
    emit(const AppRefreshingState());

    await Future.delayed(
      const Duration(milliseconds: 500),
      () => emit(AppLoaddedState(data: data30)),
    );
  }

  ///BOOKMARK CLICKED
  FutureOr<void> bookmarkClicked(
      BookmarkClicked event, Emitter<AppState> emit) {
    bookmarkHandler(data, bookmarkList, event.article);
    emit(AppLoaddedState(data: data));
  }

  ///SETTINGS CLICKED
  FutureOr<void> appSettingChangedSwitchEvent(
      AppSettingChangedSwitchEvent event, Emitter<AppState> emit) {
    switch (event.switchType) {
      case SwitchType.darkMode:
        darkModeHandler(this, event.isOn);
        emit(AppLoaddedState(data: data));
        break;
      case SwitchType.expandedSummary:
        expandedHandler(this, event.isOn);
        break;
      default:
    }
  }

  FutureOr<void> appSettingChangedPickerEvent(
      AppSettingChangedPickerEvent event, Emitter<AppState> emit) {
    switch (event.switchType) {
      case SwitchType.textScaleFactor:
        textScaleHandler(this, event.position);
        break;
      default:
    }
  }

  FutureOr<void> appSettingChangedLanguageEvent(
      AppSettingChangedLanguageEvent event, Emitter<AppState> emit) {
    languageHandler(this, event.context);
  }
}
