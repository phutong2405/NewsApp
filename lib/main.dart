import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/views/appbloc_control.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],
      path: 'lib/assets/translations/',
      fallbackLocale: const Locale('vi'),
      child: const MyApp()));
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
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocControl(
        appBloc: appBloc,
      ),
    );
  }
}
