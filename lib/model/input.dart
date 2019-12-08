import 'package:flutter/material.dart';

abstract class BaseInput extends StatelessWidget {

  getText();
}


class NumberInput extends BaseInput {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
    );
  }

  @override
  getText(){
    return _controller.text;
  }

  TextEditingController get controller => _controller;


}
