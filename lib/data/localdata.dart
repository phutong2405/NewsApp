import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSettingDataService {
  LocalSettingDataService._();
  static final LocalSettingDataService instance = LocalSettingDataService._();

  double _textScaleFactor = 0.94;
  bool _darkMode = false;
  bool _expandedSummary = false;
  String _language = "en";

  Future inital() async {
    final LocalSettingData localSettingData = LocalSettingData();
    localSettingData.inital();
    _textScaleFactor = await localSettingData.getTextScale();
    _darkMode = await localSettingData.getDarkmode();
    _expandedSummary = await localSettingData.getExpanded();
    _language = await localSettingData.getLanguage();
  }

  void setTextScaleFactor(double size) {
    _textScaleFactor = size;
    LocalSettingData().setTextScale(size);
  }

  void setDarkMode() {
    _darkMode = !_darkMode;
    LocalSettingData().setDarkmode(_darkMode);
  }

  void setExpanded() {
    _expandedSummary = !_expandedSummary;
    LocalSettingData().setExpanded(_expandedSummary);
  }

  void setLanguage(String language) {
    switch (language) {
      case "en":
        _language = "en";
        LocalSettingData().setLanguage("en");
        break;

      case "vi":
        _language = "vi";
        LocalSettingData().setLanguage("vi");
        break;
    }
  }

  get getTextScaleFactor {
    return _textScaleFactor;
  }

  get getTextScaleFactorPosition {
    switch (_textScaleFactor) {
      case 0.88:
        return 0;

      case 0.94:
        return 1;

      case 1:
        return 2;

      default:
        return 1;
    }
  }

  get getDarkMode {
    return _darkMode;
  }

  get getExpandedSum {
    return _expandedSummary;
  }

  get getLanguagePosition {
    switch (_language) {
      case "en":
        return 0;
      case "vi":
        return 1;
      default:
        return 0;
    }
  }
}

class LocalSettingData {
  inital() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? init = prefs.getBool("initial");
    if (init == null || init == false) {
      init = await prefs.setBool("initial", true);
      prefs.setDouble("textScaleFactor", 0.94);
      prefs.setBool("darkMode", false);
      prefs.setBool("expandedSummary", false);
      prefs.setString("getLanguage", "en");
    }
  }

  Future<double> getTextScale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("textScaleFactor") ?? 0.94;
  }

  void setTextScale(double size) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("textScaleFactor", size);
  }

  Future<bool> getDarkmode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("darkMode") ?? false;
  }

  void setDarkmode(bool flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", flag);
  }

  Future<bool> getExpanded() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("expandedSummary") ?? false;
  }

  void setExpanded(bool flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("expandedSummary", flag);
  }

  Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("getLanguage") ?? "en";
  }

  void setLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("getLanguage", language);
  }
}
