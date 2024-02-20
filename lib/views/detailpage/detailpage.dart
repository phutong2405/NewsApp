import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/views/detailpage/detailpage_appbar.dart';
import 'package:newsapplication/views/detailpage/detailpage_body.dart';
import 'package:newsapplication/views/widgets/fab.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double? expandedHeight = 0.0;
  Icon icon = const Icon(
    CupertinoIcons.chevron_down,
    size: 22,
    color: Colors.blueGrey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: <Widget>[
          //AppBar
          const DetailPageAppBar(),
          //Body
          DetailPageBody(expandedHeight: expandedHeight, icon: icon),
        ],
      ),
      floatingActionButton: fabDetailPage(context),
    );
  }
}
