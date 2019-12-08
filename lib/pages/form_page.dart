
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:judge/bloc/judge_bloc.dart';
import 'package:judge/model/dynamic_form.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  bool _isSending = false;

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    final DynamicForm dynamicForm = DynamicForm.build(args['form']);

    return Scaffold(
      appBar: AppBar(),
      body: _body(context, dynamicForm, args),
    );
  }



  _body(context, dynamicForm, args){
    return Column(
      children: <Widget>[

        Text(args['team']['name']),
        Expanded(
            child: dynamicForm
        ),
        RaisedButton(
          child: !_isSending ? Text('Send') : CircularProgressIndicator(
            value: null,
          ),
          onPressed: () async {
            setState(() {
              _isSending = true;
            });
            await BlocProvider.getBloc<JudgeBloc>().sendFormToServer(dynamicForm.buildResult(), args);
            Navigator.of(context).pushReplacementNamed('info');
          },
        )
      ],
    );
  }
}
