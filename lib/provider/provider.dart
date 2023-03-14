import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyProvider extends ChangeNotifier {
  var userInput = '';
  var answer = '';
  List history = [
    // {
    //   // "Value": '5',
    //   // "Resutl": '4',
    // }
  ];
  addhistory(value, result) {
    history.add({"Value": value, "Result": result});
    notifyListeners();
  }

// Array of button
  final List<String> buttonslist = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  //function

//add value on tap
  addvalue(no) {
    userInput += buttonslist[no];
    notifyListeners();
  }

  //clear value
  clear() {
    userInput = '';
    answer = '0';
    notifyListeners();
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    notifyListeners();
  }

  deletevalue() {
    userInput = userInput.substring(0, userInput.length - 1);
    notifyListeners();
  }
}
