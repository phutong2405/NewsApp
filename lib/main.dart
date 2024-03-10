import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/data/localdata.dart';
import 'package:newsapplication/firebase_options.dart';
import 'package:newsapplication/views/appbloc_control.dart';
import 'package:newsapplication/views/sideview/overlays/loading_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],
      path: 'lib/assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppBloc appBloc;

  @override
  void initState() {
    super.initState();
    initLocal();
  }

  void initLocal() async {
    appBloc = AppBloc();
    appBloc.add(const AppInitialEvent());
    await appBloc.localSettingDataService.inital();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: appBloc,
        builder: (context, state) => BlocControl(appBloc: appBloc));
  }
}
