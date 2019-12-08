

import 'package:flutter/cupertino.dart';
import 'package:judge/model/input.dart';

class Question extends StatelessWidget{

  final String _label;
  final Widget _title;
  final BaseInput _input;

  Question(this._label, this._title, this._input);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: <Widget>[
        title,
        input
      ],
    );
  }

  BaseInput get input => _input;

  Widget get title => _title;

  String get label => _label;

  toResultMap(){
    return {
      'label': label,
      'result': input.getText()
    };
  }
}