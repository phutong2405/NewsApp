import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/bloc/blocbrain.dart';
import 'package:newsapplication/data/localdata.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/preferencepage/cupertinoswitch.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  User? user;
  late List<Article> data;
  final List<Article> bookmarkList = [];
  final LocalSettingDataService localSettingDataService =
      LocalSettingDataService.instance;

  AppBloc() : super(const AppInitialState()) {
    on<AppInitialEvent>(appInitialEvent);
    on<AppRefreshEvent>(appRefreshEvent);

    ////Function Clicked
    on<BookmarkClicked>(bookmarkClicked);
    on<WebCliked>(webCliked);

    ///Settings Data Update
    on<AppSettingChangedSwitchEvent>(appSettingChangedSwitchEvent);
    on<AppSettingChangedPickerEvent>(appSettingChangedPickerEvent);
    on<AppSettingChangedLanguageEvent>(appSettingChangedLanguageEvent);

    ///Log in/out - Register
    on<AppLoginEvent>(appLoginEvent);
    on<AppRegisterEvent>(appRegisterEvent);
    on<AppLogoutEvent>(appLogoutEvent);
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
    emit(AppSnackBarState(event.article.isBookmarked
        ? tr("snackbookmarkadd")
        : tr("snackbookmarkremove")));
    emit(AppLoaddedState(data: data));
  }

  ///DETAILS CLICKED
  FutureOr<void> webCliked(WebCliked event, Emitter<AppState> emit) {
    emit(const AppLoadingEventState());
    try {
      launchURLInBrowser(event.url);
      emit(const AppOutState());
      emit(AppLoaddedState(data: data));
    } catch (e) {
      // emit(EventFailState(e));
    }
  }

  ///SETTINGS CLICKED
  FutureOr<void> appSettingChangedSwitchEvent(
      AppSettingChangedSwitchEvent event, Emitter<AppState> emit) {
    switch (event.switchType) {
      case SwitchType.darkMode:
        darkModeHandler(this, event.isOn);
        emit(const AppDarkModeState());
        emit(AppSnackBarState(tr("snackdarkmode")));
        emit(AppLoaddedState(data: data));
        break;
      case SwitchType.expandedSummary:
        expandedHandler(this, event.isOn);
        emit(AppSnackBarState(tr("snackexpanded")));
        emit(AppLoaddedState(data: data));

        break;
      default:
    }
  }

  FutureOr<void> appSettingChangedPickerEvent(
      AppSettingChangedPickerEvent event, Emitter<AppState> emit) {
    switch (event.switchType) {
      case SwitchType.textScaleFactor:
        textScaleHandler(this, event.position);
        emit(AppSnackBarState(tr("snacktextsize")));
        emit(AppLoaddedState(data: data));
        break;
      default:
    }
  }

  FutureOr<void> appSettingChangedLanguageEvent(
      AppSettingChangedLanguageEvent event, Emitter<AppState> emit) {
    languageHandler(this, event.context);
    emit(AppSnackBarState(tr("snacklanguage")));
    emit(AppLoaddedState(data: data));
  }

  /// LOG
  FutureOr<void> appLoginEvent(
      AppLoginEvent event, Emitter<AppState> emit) async {
    User? userFromAuth;
    FirebaseAuthException? eFromAuth;

    emit(const AppLoadingEventState());
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        (userFromAuth, eFromAuth) = await loginHandler(
          context: event.context,
          email: event.email,
          password: event.password,
        );
      },
    );

    if (userFromAuth != null) {
      emit(LoggedState(isLogged: true));
      emit(EventSuccessfulState(tr("loginsuccess")));
    } else {
      emit(EventFailState(eFromAuth!));
      emit(LoggedState(isLogged: false));
    }
    user = userFromAuth;
    emit(AppLoaddedState(data: data));
  }

  FutureOr<void> appRegisterEvent(
      AppRegisterEvent event, Emitter<AppState> emit) async {
    emit(const AppLoadingEventState());
    final (bool isSuccessed, FirebaseAuthException? e) = await registerHandler(
      context: event.context,
      email: event.email,
      password: event.password,
      confirmPassword: event.confirmPassword,
    );
    if (isSuccessed) {
      emit(EventSuccessfulState(tr("registersuccess")));
    } else {
      emit(EventFailState(e!));
    }
    emit(AppLoaddedState(data: data));
  }

  FutureOr<void> appLogoutEvent(
      AppLogoutEvent event, Emitter<AppState> emit) async {
    emit(const AppLoadingEventState());

    final isLogged = await logoutHandler(event.context, user);
    if (isLogged) {
      user = null;
      emit(LoggedState(isLogged: false));
      emit(EventSuccessfulState(tr("logoutsuccess")));
      emit(AppLoaddedState(data: data));
    } else {}
  }
}
