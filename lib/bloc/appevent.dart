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

///SETTINGS
class AppSettingChangedEvent implements AppEvent {
  const AppSettingChangedEvent();
}

class AppSettingChangedSwitchEvent implements AppSettingChangedEvent {
  final SwitchType switchType;
  final bool isOn;
  const AppSettingChangedSwitchEvent({
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
