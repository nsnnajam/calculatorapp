// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:calculatorapp/provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeSecreen extends StatefulWidget {
  const HomeSecreen({super.key});

  @override
  State<HomeSecreen> createState() => _HomeSecreenState();
}

class _HomeSecreenState extends State<HomeSecreen> {
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context, listen: false);
    print(myProvider.history);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<MyProvider>(
            builder: (context, value, child) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 200,
                          width: 250,
                          color: Colors.amber,
                          child: Column(
                            children: [
                              Text("Hostory"),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.history.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Text(
                                          'Value: ${value.history[index]["Value"].toString()}'),
                                      Text(
                                          ' Result: ${value.history[index]["Result"].toString()}'),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(20),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  value.userInput,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.all(15),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  value.answer,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                  //gridview
                  Expanded(
                      flex: 2,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.buttonslist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return MyButton(
                              buttontapped: () {
                                value.clear();
                              },
                              buttonText: value.buttonslist[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }
                          // +/- button
                          else if (index == 1) {
                            return MyButton(
                              buttonText: value.buttonslist[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }
                          // % Button
                          else if (index == 2) {
                            return MyButton(
                              // buttontapped: () {
                              //
                              // },
                              buttonText: value.buttonslist[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          }
                          // Delete Button
                          else if (index == 3) {
                            return MyButton(
                              buttontapped: () {
                                value.deletevalue();
                              },
                              buttonText: value.buttonslist[index],
                              color: Colors.blue[50],
                              textColor: Colors.black,
                            );
                          } else if (index == 18) {
                            return MyButton(
                              buttontapped: () {
                                value.equalPressed();
                                value.addhistory(value.userInput, value.answer);
                              },
                              buttonText: value.buttonslist[index],
                              color: Color.fromARGB(255, 0, 245, 29),
                              textColor: Colors.white,
                            );
                          } else {
                            return MyButton(
                              buttontapped: () {
                                value.addvalue(index);
                              },
                              buttonText: value.buttonslist[index],
                              color: isOperator(value.buttonslist[index])
                                  ? Colors.blueAccent
                                  : Colors.white,
                              textColor: isOperator(value.buttonslist[index])
                                  ? Colors.white
                                  : Colors.black,
                            );
                          }
                        },
                      ))
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}

bool isOperator(String x) {
  if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables

//Constructor
  MyButton({this.color, this.textColor, this.buttonText, this.buttontapped});

  final color;
  final textColor;
  final buttonText;
  final buttontapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      focusColor: Colors.tealAccent,
      hoverColor: Colors.amber,
      highlightColor: Colors.deepOrange,
      child: GestureDetector(
        onTap: buttontapped,
        child: Padding(
          padding: const EdgeInsets.all(0.2),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(25),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
