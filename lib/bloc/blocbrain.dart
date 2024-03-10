import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/services/authentication/auth.dart';
import 'package:url_launcher/url_launcher.dart';

// List<Article> data30 = articleSpawn(amount: 30);

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

///LOG HANDLER
Future<(User?, FirebaseAuthException?)> loginHandler(
    {required BuildContext context,
    required String email,
    required String password}) async {
  var (userFromAuth, eFromAuth) =
      await AuthService().login(email: email, password: password);
  return (userFromAuth, eFromAuth);
}

Future<(bool, FirebaseAuthException?)> registerHandler(
    {required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword}) async {
  FirebaseAuthException? registerReturn = await AuthService().registration(
    email: email,
    password: password,
    confirmPassword: confirmPassword,
  );
  if (registerReturn != null) {
    return (false, registerReturn);
  } else {
    return (true, null);
  }
}

Future<bool> logoutHandler(BuildContext context, User? user) async {
  if (user != null) {
    int logged = await AuthService().logout(user: user);

    if (logged == 1) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
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
      break;

    case 1:
      textScaleFactor = 0.94;
      break;

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

void launchURLInBrowser(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
