import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/views/preferencepage/cupertinopicker.dart';
import 'package:newsapplication/views/preferencepage/cupertinoswitch.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

class PreferencePage extends StatefulWidget {
  final AppBloc appBloc;
  const PreferencePage({super.key, required this.appBloc});

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      onClosing: () {},
      builder: (context) => CustomScrollView(
        slivers: <Widget>[
          preferenceAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                divineSpace(height: 10),
                // accountInformationLogin(context),
                accountInformation(context),

                divineSpace(height: 30),

                textSize(
                  context,
                  widget.appBloc,
                  SwitchType.textScaleFactor,
                ),
                divineSpace(height: 10),
                listTileWswitch(
                  context,
                  const Icon(
                    Icons.dark_mode_outlined,
                    size: 20,
                  ),
                  tr("darkmode"),
                  widget.appBloc,
                  SwitchType.darkMode,
                ),
                divineSpace(height: 10),
                listTileWswitch(
                  context,
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 20,
                  ),
                  tr("expanded"),
                  widget.appBloc,
                  SwitchType.expandedSummary,
                ),
                // divineSpace(height: 10),
                // warmPage(context),

                divineSpace(height: 30),
                listTileWswitch(
                  context,
                  const Icon(
                    Icons.translate_rounded,
                    size: 20,
                  ),
                  tr("autotrans"),
                  widget.appBloc,
                  SwitchType.autoTranslate,
                ),
                divineSpace(height: 10),
                // translateTo(
                //   context,
                //   widget.appBloc,
                // ),
                // divineSpace(height: 10),
                languagesChoice(
                  context,
                  widget.appBloc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget preferenceAppBar(BuildContext context) {
  return SliverAppBar(
    foregroundColor: Colors.white,
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: Container(
      padding: const EdgeInsets.only(left: 20.0),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          CupertinoIcons.chevron_down,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
    pinned: false,
    floating: true,
    // floating: true,
    surfaceTintColor: Colors.white,
    toolbarHeight: 50,
    expandedHeight: 55.0,
    collapsedHeight: 55,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        'Preference',
        style: GoogleFonts.aladin(
          fontSize: 28,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    ),
  );
}

Widget listTileCustom({
  required BuildContext context,
  required Icon leading,
  required String title,
  required Widget trailing,
}) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(
      left: 15,
      right: 15,
    ),
    decoration: BoxDecoration(
      border: Border.all(width: 0.1),
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(
        170,
        234,
        220,
        198,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: leading,
        ),
        divineSpace(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 50,
          width: 100,
          child: trailing,
        )
      ],
    ),
  );
}

Widget accountInformation(BuildContext context) {
  return listTileCustom(
    context: context,
    leading: const Icon(
      Icons.person_outline,
      size: 20,
    ),
    title: "phutong2405@gmail.com",
    // trailing: IconButton(
    //     splashColor: Colors.transparent,
    //     highlightColor: Colors.transparent,
    //     onPressed: () {},
    //     icon: Icon(
    //       Icons.logout,
    //       color: Colors.black.withRed(180),
    //     )));
    trailing: CupertinoButton(
      padding: const EdgeInsets.all(5),
      child: Text(
        "Logout",
        style: GoogleFonts.openSans(
          fontSize: 15,
          color: Colors.black.withRed(150),
        ),
      ),
      onPressed: () {},
    ),
  );
}

Widget accountInformationLogin(BuildContext context) {
  return listTileCustom(
    context: context,
    leading: const Icon(
      Icons.person_outline,
      size: 20,
    ),
    title: "Login by Google account",
    // trailing: IconButton(
    //     splashColor: Colors.transparent,
    //     highlightColor: Colors.transparent,
    //     onPressed: () {},
    //     icon: Icon(
    //       Icons.login,
    //       color: Colors.black.withGreen(180),
    //     )));
    trailing: CupertinoButton(
      padding: const EdgeInsets.all(5),
      child: Text(
        "Login",
        style: GoogleFonts.openSans(
          fontSize: 15,
          color: Colors.black.withGreen(150),
        ),
      ),
      onPressed: () {},
    ),
  );
}

Widget textSize(BuildContext context, AppBloc appBloc, SwitchType switchType) {
  List<String> textSize = <String>[tr("small"), tr("medium"), tr("large")];
  final textSizePicker = CupertinoPickerCustom(
    appBloc: appBloc,
    switchType: switchType,
    selectionsName: textSize,
    title: tr("textsize"),
    iconData: CupertinoIcons.textformat_size,
  );

  return textSizePicker;
}

Widget warmPage(BuildContext context) {
  return listTileCustom(
    context: context,
    leading: const Icon(
      CupertinoIcons.lightbulb,
      size: 20,
    ),
    title: "page's temperature",
    trailing: CupertinoButton(
      padding: const EdgeInsets.all(5),
      child: Text(
        "Hot",
        style: GoogleFonts.openSans(fontSize: 15),
      ),
      onPressed: () {},
    ),
  );
}

Widget listTileWswitch(BuildContext context, Icon icon, String title,
    AppBloc appBloc, SwitchType switchType) {
  return listTileCustom(
    context: context,
    leading: icon,
    title: title,
    trailing: CupertinoSwitchCustom(
      appBloc: appBloc,
      switchType: switchType,
    ),
  );
}

Widget languagesChoice(BuildContext context, AppBloc appBloc) {
  List<String> languages = <String>[tr("en"), tr("vi")];
  final languagePicker = CupertinoPickerCustom(
    appBloc: appBloc,
    switchType: SwitchType.languages,
    selectionsName: languages,
    title: tr("languages"),
    iconData: Icons.language,
  );
  return languagePicker;
}

// Widget translateTo(BuildContext context, AppBloc appBloc) {
//   const List<String> languagesToTranslate = <String>["English", "Tiếng Việt"];
//   final translateToPicker = CupertinoPickerCustom(
//     appBloc: appBloc,
//     selectionsName: languagesToTranslate,
//     switchType: SwitchType.translateTo,
//     title: "Translate to",
//     iconData: Icons.translate,
//     initialName: ,
//   );
//   return translateToPicker;
// }
