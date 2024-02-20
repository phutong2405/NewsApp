import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/bloc/appbloc.dart';
import 'package:newsapplication/bloc/appevent.dart';
import 'package:newsapplication/views/appbloc_control.dart';
import 'package:newsapplication/views/home/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppBloc appBloc;
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    appBloc.add(const AppInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Hỗ trợ dark mode theo hệ thống
      darkTheme: ThemeData.dark(), // Giao diện dark mode
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ), // Giao diện light mode
      home: BlocProvider(
        create: (context) => AppBloc(),
        child: BlocControl(
          appBloc: appBloc,
        ),
        // child: HomePage(appBloc: appBloc),
      ),
    );
  }
}
