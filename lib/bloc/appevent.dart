import 'package:flutter/material.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/preferencepage/cupertinoswitch.dart';

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

class WebCliked implements AppEvent {
  final BuildContext context;
  final String url;
  const WebCliked({required this.context, required this.url});
}

///LOG IN
class AppLoginEvent implements AppEvent {
  final BuildContext context;
  final String email;
  final String password;
  const AppLoginEvent(
      {required this.context, required this.email, required this.password});
}

class AppRegisterEvent implements AppEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String confirmPassword;
  const AppRegisterEvent(
      {required this.context,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

class AppLogoutEvent implements AppEvent {
  final BuildContext context;
  const AppLogoutEvent(this.context);
}

///SETTINGS
class AppSettingChangedEvent implements AppEvent {
  const AppSettingChangedEvent();
}

class AppSettingChangedSwitchEvent implements AppSettingChangedEvent {
  final BuildContext context;
  final SwitchType switchType;
  final bool isOn;
  const AppSettingChangedSwitchEvent({
    required this.context,
    required this.switchType,
    required this.isOn,
  });
}

class AppSettingChangedPickerEvent implements AppSettingChangedEvent {
  final SwitchType switchType;
  final int position;
  const AppSettingChangedPickerEvent({
    required this.switchType,
    required this.position,
  });
}

class AppSettingChangedLanguageEvent implements AppSettingChangedEvent {
  final SwitchType switchType;
  final BuildContext context;
  const AppSettingChangedLanguageEvent({
    required this.switchType,
    required this.context,
  });
}
