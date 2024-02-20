import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

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

                textSize(context),
                divineSpace(height: 10),
                listTileWswitch(
                  context,
                  const Icon(
                    Icons.dark_mode_outlined,
                    size: 20,
                  ),
                  "darkmode",
                  () {},
                ),
                divineSpace(height: 10),
                listTileWswitch(
                  context,
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 20,
                  ),
                  "expanded summary",
                  () {},
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
                  "auto-translate",
                  () {},
                ),
                divineSpace(height: 10),
                translateTo(context),
                divineSpace(height: 10),
                languagesChoice(context),
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
          width: 200,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
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

Widget textSize(BuildContext context) {
  return listTileCustom(
    context: context,
    leading: const Icon(
      CupertinoIcons.book,
      size: 20,
    ),
    title: "text size",
    trailing: CupertinoButton(
      padding: const EdgeInsets.all(5),
      child: Text(
        "Normal",
        style: GoogleFonts.openSans(fontSize: 15),
      ),
      onPressed: () {},
    ),
  );
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

Widget listTileWswitch(
    BuildContext context, Icon icon, String title, Function func) {
  return listTileCustom(
    context: context,
    leading: icon,
    title: title,
    trailing: CupertinoSwitch(
      // thumbColor: Colors.black,
      // activeColor: Colors.blueGrey,
      value: true,
      onChanged: (value) {
        func();
      },
    ),
  );
}

Widget languagesChoice(BuildContext context) {
  return listTileCustom(
    context: context,
    leading: const Icon(Icons.language),
    title: "app's language",
    trailing: CupertinoButton(
      padding: const EdgeInsets.all(5),
      child: Text(
        "English",
        style: GoogleFonts.openSans(fontSize: 15),
      ),
      onPressed: () {},
    ),
  );
}

Widget translateTo(BuildContext context) {
  return listTileCustom(
    context: context,
    leading: const Icon(Icons.read_more),
    title: "translate to",
    trailing: CupertinoButton(
      padding: const EdgeInsets.all(5),
      child: Text(
        "Vietnamese",
        style: GoogleFonts.openSans(fontSize: 15),
      ),
      onPressed: () {},
    ),
  );
}
