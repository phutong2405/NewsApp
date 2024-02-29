import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/views/home/homepage.dart';

class BlocControl extends StatefulWidget {
  final AppBloc appBloc;
  const BlocControl({super.key, required this.appBloc});

  @override
  State<BlocControl> createState() => _BlocControlState();
}

class _BlocControlState extends State<BlocControl> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.appBloc,
      listenWhen: (previous, current) => current is AppActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case AppLoaddedState:
            state as AppLoaddedState;
            return mainPage(
              context,
              widget.appBloc,
              HomePage(appBloc: widget.appBloc, data: state.data),
            );

          case AppRefreshingState:
            return mainPage(
              context,
              widget.appBloc,
              Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: CustomScrollView(
                  slivers: <Widget>[
                    ///AppBar
                    homepageAppBar(context, widget.appBloc),
                    const SliverToBoxAdapter(
                      child: CupertinoActivityIndicator(radius: 12),
                    )
                    //Body
                  ],
                ),
              ),
            );

          case AppLoaddingState:
            return mainPage(
              context,
              widget.appBloc,
              Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget mainPage(BuildContext context, AppBloc appBloc, Widget home) {
    print("run");
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      themeMode: widget.appBloc.localSettingDataService.getDarkMode
          ? ThemeMode.system
          : ThemeMode.light, // Hỗ trợ dark mode theo hệ thống
      darkTheme: ThemeData.dark(), // Giao diện dark mode
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ), // Giao diện light mode
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: home,
    );
  }
}
