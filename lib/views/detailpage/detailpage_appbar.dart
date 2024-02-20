import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/views/widgets/generic_widgets.dart';

class DetailPageAppBar extends StatelessWidget {
  const DetailPageAppBar({super.key});

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
            onPressed: () {},
            icon: const Icon(CupertinoIcons.bookmark)),
        IconButton.filled(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            selectedIcon: const Icon(
              Icons.bolt,
              color: Colors.red,
            ),
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {},
            icon: const Icon(Icons.translate_rounded)),
        divineSpace(width: 10),
      ],
    );
  }
}
