import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/views/filterpage/filterpage.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

Widget fabToTop(BuildContext context) {
  return fabSFBlueprint(
    func: () {},
    content: Icon(
      CupertinoIcons.arrow_up_to_line,
      color: Theme.of(context).colorScheme.onBackground,
    ),
  );
}

Widget fabHomePage(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      fabSFBlueprint(
        func: () {
          Navigator.push(
            context,
            CupertinoDialogRoute(
              context: context,
              builder: (context) => const FilterPage(),
              // fullscreenDialog: true
            ),
          );
        },
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 180, maxHeight: 50),
              child: Text(
                "The New York Times",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            divineSpace(width: 10),
            const Icon(CupertinoIcons.doc_append),
            Text(
              " | ",
              style: GoogleFonts.openSans(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Icon(
              CupertinoIcons.search,
              size: 20,
            ),
          ],
        ),
      ),
      divineSpace(width: 15),
      fabSFBlueprint(
        func: () {},
        content: Icon(
          CupertinoIcons.arrow_up_to_line,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    ],
  );
}

Widget fabDetailPage(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      fabSFBlueprint(
        func: () {},
        content: Row(
          children: [
            const Icon(CupertinoIcons.headphones),
            divineSpace(width: 10),
            Text(
              "Audio",
              style: GoogleFonts.openSans(
                  fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      divineSpace(width: 10),
      fabSFBlueprint(
        func: () {},
        content: Icon(
          CupertinoIcons.arrow_up_to_line,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    ],
  );
}

Widget fabSFBlueprint({required Widget content, required Function func}) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      func();
    },
    child: GlassContainer(
      shadowStrength: 8,
      gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
        Colors.purple,
        Colors.amber,
        Colors.pink,
      ]),
      blur: 25,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: content,
      ),
    ),
  );
}
