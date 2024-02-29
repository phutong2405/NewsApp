import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/models/article.dart';

List<Article> data30 = articleSpawn(amount: 30);

///BOOKMARK HANDLER
extension SetBookmark on List<Article> {
  setBookmark(Article article) {
    if (length > 0) {
      final index = indexOf(article);
      setAll(index, [article]);
    }
  }
}

extension AddToBookMark on List<Article> {
  addToBookmark(Article article) {
    if (contains(article)) {
      remove(article);
    } else {
      add(article);
    }
  }
}

void bookmarkHandler(
  List<Article> data,
  List<Article> bookmarkList,
  Article article,
) {
  article.setBookmark();
  bookmarkList.addToBookmark(article);
  data.setBookmark(article);
}

///SETTINGS HANDLER
void darkModeHandler(AppBloc appBloc, bool value) {
  appBloc.localSettingDataService.setDarkMode();
}

void expandedHandler(AppBloc appBloc, bool value) {
  appBloc.localSettingDataService.setExpanded();
}

void textScaleHandler(AppBloc appBloc, int position) {
  late final double textScaleFactor;
  switch (position) {
    case 0:
      textScaleFactor = 0.88;

    case 1:
      textScaleFactor = 0.94;

    case 2:
      textScaleFactor = 1;
  }
  appBloc.localSettingDataService.setTextScaleFactor(textScaleFactor);
}

void languageHandler(AppBloc appBloc, BuildContext context) {
  Locale currentLocale = context.locale;
  Locale newLocale;

  if (currentLocale == const Locale("en")) {
    newLocale = const Locale("vi");
    appBloc.localSettingDataService.setLanguage("vi");
  } else {
    newLocale = const Locale("en");
    appBloc.localSettingDataService.setLanguage("en");
  }

  EasyLocalization.of(context)!.setLocale(newLocale);
}
