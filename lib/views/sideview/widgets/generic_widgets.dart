import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget divineSpace({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

Widget divineLine(
    {required List<Color> colors,
    required double space,
    double? size,
    double? spaceTop,
    double? spaceBot,
    required AlignmentGeometry start}) {
  return Column(
    children: [
      SizedBox(
        height: spaceTop ?? space,
      ),
      Container(
        height: size ?? 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors, begin: start),
        ),
      ),
      SizedBox(
        height: spaceBot ?? space,
      ),
    ],
  );
}

typedef TextButtonTapped = void Function();

TextButton genericTextButton(
    {required BuildContext context,
    required IconData icon,
    required String text,
    required Color bgcolor,
    Color? colorTapped,
    required double sized,
    bool? tapped,
    required TextButtonTapped func}) {
  tapped ??= false;
  return TextButton.icon(
    style: ButtonStyle(
      overlayColor:
          MaterialStateColor.resolveWith((states) => bgcolor.withAlpha(100)),
      backgroundColor:
          MaterialStatePropertyAll(!tapped ? bgcolor : colorTapped),
      shape: const MaterialStatePropertyAll(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(width: 0.1)),
      ),
    ),
    onPressed: () {
      func();
    },
    icon: Icon(
      size: sized,
      icon,
      color: Theme.of(context).colorScheme.onBackground,
    ),
    label: Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    ),
  );
}

Widget textButtonCustom(
    BuildContext context, String child, Color? color, Function() func) {
  return Container(
    // alignment: Alignment.centerRight,
    margin: const EdgeInsets.only(right: 15),
    child: CupertinoButton(
      // color: Colors.green.shade50.withOpacity(0.4),
      // borderRadius: BorderRadius.circular(10),
      // padding: const EdgeInsets.all(12),
      child: Text(
        child,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.openSans(
            color: color ?? Theme.of(context).colorScheme.onBackground,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        func();
      },
    ),
  );
}
