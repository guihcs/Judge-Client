

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:judge/bloc/judge_bloc.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    BlocProvider.getBloc<JudgeBloc>().onFormReceived((form){

      Navigator.of(context).pushReplacementNamed('form', arguments: form);
    });

    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }


  _body(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Judge: ' + BlocProvider.getBloc<JudgeBloc>().judgeName),
          Text('Waiting for form...')
        ],
      ),
    );
  }
}
