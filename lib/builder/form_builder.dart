

import 'package:flutter/material.dart';
import 'package:judge/model/input.dart';

abstract class FormBuilder {

  static build(String name, Map<String, dynamic> args){

    switch(name){
      case 'label': return Text(args['text']);
      case 'input': return _buildInput(args);
    }
  }



  static _buildInput(args){
    switch(args['type']){
      case 'number': return NumberInput();
    }
  }
}



