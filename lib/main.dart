
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:judge/bloc/judge_bloc.dart';
import 'package:judge/pages/form_page.dart';
import 'package:judge/pages/start_page.dart';
import 'package:judge/pages/info_page.dart';
import 'package:judge/network/network_provider.dart';

void main() async {
  await NetworkAdapter.getInstance();

  final judgeBloc = JudgeBloc();

  await judgeBloc.initialize();

  runApp(BlocProvider(
    blocs: [
      Bloc((i) => judgeBloc)
    ],
    child: JudgeApp(),
  ));
}


class JudgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: 'start',
      routes: {
        'start': (context) => StartPage(),
        'info': (context) => InfoPage(),
        'form': (context) => FormPage()
      },
    );
  }
}




