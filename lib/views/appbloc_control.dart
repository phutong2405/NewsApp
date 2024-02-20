import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appbloc.dart';
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
    print("main build");
    return BlocConsumer(
      bloc: widget.appBloc,
      listenWhen: (previous, current) => current is AppActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case AppLoaddedState:
            print("Loadded");
            state as AppLoaddedState;
            // final dataLength = entries.length;
            // print(dataLength);
            return HomePage(appBloc: widget.appBloc, data: state.data);

          case AppRefreshingState:
            return Scaffold(
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

          case AppLoaddingState:
            print("Loadding");

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
