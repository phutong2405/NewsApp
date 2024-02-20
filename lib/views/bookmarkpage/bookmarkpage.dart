import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/widgets/fab.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';
import 'package:newsapplication/views/home/homepage.dart';

class BookmarkPage extends StatefulWidget {
  final List<Article> articles;
  const BookmarkPage({super.key, required this.articles});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: <Widget>[
          bookmarkAppBar(context),
          //3
          // newsListTile(context),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          fabSFBlueprint(
            func: () {},
            content: const Icon(
              CupertinoIcons.headphones,
              color: Colors.blueGrey,
            ),
          ),
          divineSpace(width: 15),
          fabToTop(context)
        ],
      ),
    );
  }
}

Widget bookmarkAppBar(BuildContext context) {
  return SliverAppBar(
    toolbarHeight: 40,
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: IconButton(
      icon: const Icon(CupertinoIcons.back, color: Colors.black),
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
        style: GoogleFonts.aladin(color: Colors.yellow.shade800, fontSize: 28),
      ),
    ),
  );
}
