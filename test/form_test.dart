


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:judge/model/dynamic_form.dart';
import 'package:judge/model/input.dart';

void main(){

//  test('test', (){
//
//  });

  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('DynamicForm test.', (WidgetTester tester) async {

    final formData = {
      'form': [
        [
          {'type': 'label', 'args': {'text': 'Q1'}},
          {'type': 'input', 'args': {'type': 'number'}}
        ],
        [
          {'type': 'label', 'args': {'text': 'Q2'}},
          {'type': 'input', 'args': {'type': 'number'}}
        ],
        [
          {'type': 'label', 'args': {'text': 'Q3'}},
          {'type': 'input', 'args': {'type': 'number'}}
        ]
      ]
    };

    DynamicForm form = DynamicForm.build(formData['form']);


    // Test code goes here.
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: form,),));

    expect(find.text('Q1'), findsOneWidget);
    expect(find.text('Q2'), findsOneWidget);
    expect(find.text('Q3'), findsOneWidget);

    expect(find.byType(NumberInput), findsNWidgets(3));

    final inputs = find.byType(NumberInput);
    int i = 1;
    for (var element in inputs.evaluate()) {
      NumberInput input = element.widget;
      input.controller.text = 'response ${i++}';
    }

    final results = form.buildResult();
    final expectedResult = '{"results":[{"label":"Q1","result":"response 1"},{"label":"Q2","result":"response 2"},{"label":"Q3","result":"response 3"}]}';

    expect(jsonEncode(results), expectedResult);
  });

}