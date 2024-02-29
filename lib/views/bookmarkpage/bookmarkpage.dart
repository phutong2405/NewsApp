import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/home/homepage.dart';
import 'package:newsapplication/views/widgets/fab.dart';

class BookmarkPage extends StatefulWidget {
  final AppBloc appBloc;
  final List<Article> data;
  const BookmarkPage({super.key, required this.appBloc, required this.data});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder(
        bloc: widget.appBloc,
        builder: (context, state) {
          if (state is AppLoaddedState) {
            return CustomScrollView(
              slivers: <Widget>[
                ///AppBar
                bookmarkAppBar(context),

                newsListTile(
                  context,
                  widget.appBloc,
                  widget.data,
                ),
                //Body
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: fabToTop(context),
    );
  }
}

Widget bookmarkAppBar(BuildContext context) {
  return SliverAppBar(
    toolbarHeight: 40,
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(
        CupertinoIcons.back,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      onPressed: () => Navigator.of(context).pop(),
    ),
    pinned: false,
    floating: true,
    surfaceTintColor: Colors.white,
    expandedHeight: 50.0,
    collapsedHeight: 50,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        'Bookmarks',
        style: GoogleFonts.aladin(color: Colors.yellow.shade700, fontSize: 28),
      ),
    ),
  );
}
