import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/models/article.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

class DetailPageAppBar extends StatefulWidget {
  final AppBloc appBloc;
  final Article article;
  const DetailPageAppBar(
      {super.key, required this.appBloc, required this.article});

  @override
  State<DetailPageAppBar> createState() => _DetailPageAppBarState();
}

class _DetailPageAppBarState extends State<DetailPageAppBar> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      pinned: false,
      floating: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Colors.blueGrey.shade50.withOpacity(0.5),
      expandedHeight: 56.0,
      collapsedHeight: 56,
      actions: [
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {},
            icon: const Icon(CupertinoIcons.share)),
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {},
            icon: const Icon(CupertinoIcons.globe)),
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {
              setState(() {
                widget.appBloc.add(
                  BookmarkClicked(article: widget.article),
                );
              });
            },
            icon: !widget.article.isBookmarked
                ? const Icon(CupertinoIcons.bookmark)
                : const Icon(
                    CupertinoIcons.bookmark_fill,
                    color: Colors.amber,
                  )),
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {
              setState(() {
                _isSelected = !_isSelected;
              });
            },
            icon: !_isSelected
                ? const Icon(
                    Icons.translate_outlined,
                  )
                : Icon(
                    Icons.translate_outlined,
                    color: Colors.blueAccent.shade200,
                  )),
        divineSpace(width: 10),
      ],
    );
  }
}
