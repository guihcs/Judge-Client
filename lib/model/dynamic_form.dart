


import 'package:flutter/cupertino.dart';
import 'package:judge/builder/form_builder.dart';
import 'package:judge/model/input.dart';
import 'package:judge/model/question.dart';

class DynamicForm extends StatelessWidget{

  final List<Question> _questionList = [];

  DynamicForm.build(List<dynamic> formData){
    for (var questionData in formData) {

      Widget questionTitle = FormBuilder.build(questionData[0]['type'], questionData[0]['args']);
      BaseInput inputWidget = FormBuilder.build(questionData[1]['type'], questionData[1]['args']);

      Question question = Question(questionData[0]['args']['text'], questionTitle, inputWidget);

      _questionList.add(question);
    }
  }

  List<Question> get questionList => _questionList;

  buildResult(){
    List<dynamic> resultList = [];

    for (var question in questionList) {
      resultList.add(question.toResultMap());
    }

    Map<String, dynamic> resultMap = {
      'results': resultList
    };

    return resultMap;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questionList.length,
      itemBuilder: (context, index){
        return _questionList[index];
      },
    );
  }

}