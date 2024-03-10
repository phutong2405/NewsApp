import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar snackBarCustom(BuildContext context, String content) {
  return SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      side: BorderSide(width: 0.1),
    ),
    elevation: BorderSide.strokeAlignCenter,
    actionOverflowThreshold: 1,
    duration: const Duration(milliseconds: 800),
    dismissDirection: DismissDirection.vertical,
    // margin: const EdgeInsets.symmetric(horizontal: 15),
    backgroundColor:
        Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
    behavior: SnackBarBehavior.fixed,
    content: Center(
        child: SizedBox(
      height: 20,
      child: Text(
        content,
        style: GoogleFonts.openSans(
          fontSize: 13,
          color: Theme.of(context).colorScheme.background,
          fontWeight: FontWeight.bold,
        ),
      ),
    )),
    // action: SnackBarAction(
    //   label: 'Undo',
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
  );
}
