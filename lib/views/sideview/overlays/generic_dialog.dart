import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DialogOption<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOption dialogOption,
}) {
  final options = dialogOption();
  return showDialog(
    context: context,
    builder: (context) {
      return Platform.isAndroid
          ? materialAlertDialogCustom(title, content, options, context)
          : cupertinoAlertDialogCustom(title, content, options, context);
    },
  );
}

Widget cupertinoAlertDialogCustom(String title, String content,
    Map<String, dynamic> options, BuildContext context) {
  return CupertinoAlertDialog(
    title: Text(title),
    content: Text(content),
    actions: options.keys.map((keys) {
      return CupertinoDialogAction(
        textStyle: TextStyle(
          color: options[keys] == true
              ? Colors.red
              : Theme.of(context).colorScheme.onBackground,
        ),
        isDefaultAction: true,
        child: Text(keys),
        onPressed: () {
          if (options[keys] != null) {
            Navigator.of(context).pop(options[keys]);
          } else {
            Navigator.pop(context);
          }
        },
      );
    }).toList(),
  );
}

Widget materialAlertDialogCustom(String title, String content,
    Map<String, dynamic> options, BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Text(title),
    content: Text(content),
    actions: options.keys.map((keys) {
      return CupertinoDialogAction(
        textStyle: TextStyle(
          color: options[keys] == true
              ? Colors.red
              : Theme.of(context).colorScheme.onBackground,
        ),
        isDefaultAction: true,
        child: Text(keys),
        onPressed: () {
          if (options[keys] != null) {
            Navigator.of(context).pop(options[keys]);
          } else {
            Navigator.pop(context);
          }
        },
      );
    }).toList(),
  );
}
