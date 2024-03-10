import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appstate.dart';
import 'package:newsapplication/services/authentication/auth_error.dart';
import 'package:newsapplication/views/home/homepage.dart';
import 'package:newsapplication/views/sideview/overlays/generic_dialog.dart';
import 'package:newsapplication/views/sideview/overlays/loading_dialog.dart';
import 'package:newsapplication/views/sideview/widgets/snackbar.dart';

class BlocControl extends StatefulWidget {
  final AppBloc appBloc;
  const BlocControl({super.key, required this.appBloc});

  @override
  State<BlocControl> createState() => _BlocControlState();
}

class _BlocControlState extends State<BlocControl> {
  @override
  Widget build(BuildContext context) {
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
      home: BlocConsumer(
        bloc: widget.appBloc,
        listenWhen: (previous, current) =>
            current is AppState || current is EventSuccessfulState,
        listener: (context, state) {
          if (state is AppLoadingEventState) {
            LoadingOverlay.instance().hide();
            LoadingOverlay.instance().show(
              context: context,
            );
          }

          if (state is AppSnackBarState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            final snackBar = snackBarCustom(context, state.content);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is EventSuccessfulState) {
            LoadingOverlay.instance().hide();
            Navigator.pop(context);
            showGenericDialog(
              context: context,
              title: "Successful",
              content: state.content,
              dialogOption: () => {'OK': false},
            );
          }

          if (state is EventFailState) {
            LoadingOverlay.instance().hide();
            final eTitle = AuthError.from(state.error).dialogTitle;
            final eText = AuthError.from(state.error).dialogText;
            showGenericDialog(
              context: context,
              title: eTitle,
              content: eText,
              dialogOption: () => {'OK': false},
            );
          }

          if (state is AppOutState) {
            // Navigator.pop(context);
            LoadingOverlay.instance().hide();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (AppLoaddedState):
              state as AppLoaddedState;
              return HomePage(appBloc: widget.appBloc, data: state.data);

            case const (AppRefreshingState):
              return Scaffold(
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
              );

            case const (AppLoaddingState):
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
