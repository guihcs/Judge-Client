

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:judge/bloc/judge_bloc.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  TextEditingController _controller = TextEditingController();

  bool _isLoading = false;
  bool _canSend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: !_isLoading ? _form() :  _loadScreen(),
    );
  }


  _form(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Code'
            ),
          ),
          RaisedButton(
            child: Text('SEND'),
            onPressed: () async {

              JudgeBloc judgeBloc =  BlocProvider.getBloc<JudgeBloc>();
              setState(() {
                _canSend = true;
                _isLoading = true;
              });
              while(!judgeBloc.isConnected && _canSend){
                await judgeBloc.startMulticast(_controller.text);
              }
              if(_canSend){
                Navigator.pushReplacementNamed(context, 'info');
              }
              _canSend = false;
              BlocProvider.getBloc<JudgeBloc>().stopMulticast();
            },
          )
        ],
      ),
    );
  }

  _loadScreen() {
    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Loading'),
          Container(

            child: CircularProgressIndicator(
              value: null,
            ),
          ),
          RaisedButton(

            onPressed: (){
              setState(() {
                _isLoading = false;
                _canSend = false;
                BlocProvider.getBloc<JudgeBloc>().stopMulticast();
              });

            },
          )
        ],
      ),
    );
  }
}
