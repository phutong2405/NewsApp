import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/detailpage/detailpage_appbar.dart';
import 'package:newsapplication/views/detailpage/detailpage_body.dart';
import 'package:newsapplication/views/widgets/fab.dart';

class DetailPage extends StatelessWidget {
  final AppBloc appBloc;
  final Article article;
  const DetailPage({super.key, required this.appBloc, required this.article});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    double? expandedHeight =
        appBloc.localSettingDataService.getExpandedSum ? null : 0;
    Icon icon = !appBloc.localSettingDataService.getExpandedSum
        ? const Icon(
            CupertinoIcons.chevron_down,
            size: 22,
            color: Colors.blueGrey,
          )
        : const Icon(
            CupertinoIcons.chevron_up,
            size: 22,
            color: Colors.blueGrey,
          );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          //AppBar
          DetailPageAppBar(appBloc: appBloc, article: article),
          //Body
          DetailPageBody(
              appBloc: appBloc,
              article: article,
              expandedHeight: expandedHeight,
              icon: icon),
        ],
      ),
      floatingActionButton: fabDetailPage(context, controller),
    );
  }
}
