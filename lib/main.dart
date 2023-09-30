import 'package:calculator_app/buttonicons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  var question = "";
  var answer = "";
  bool isoperator(String s) {
    return s == '+' || s == 'x' || s == '-' || s == '/' || s == '=' || s == '%';
  }

  void equal() {
    question = question.replaceAll('x', '*');

    Parser p = Parser();
    Expression e = p.parse(question);
    ContextModel cm = ContextModel();
    double eval = e.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }

  int count = 0;
  List<String> mybuttons = [
    'C',
    'DEL',
    '%',
    'x',
    '9',
    '8',
    '7',
    '/',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '0',
    '.',
    'ANS',
    '='
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 30.0),
                    )),
                const SizedBox(
                  height: 45.0,
                ),
                Container(
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: mybuttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (mybuttons[index] == 'C') {
                        return Buttons(
                          button: mybuttons[index],
                          text: Colors.white,
                          background: Colors.green,
                          clicked: () {
                            count += 1;
                            setState(() {
                              question = '';
                              if (count > 2) {
                                answer = '';
                              }
                            });
                          },
                        );
                      } else if (mybuttons[index] == 'DEL') {
                        return Buttons(
                          button: mybuttons[index],
                          text: Colors.white,
                          background: Colors.red,
                          clicked: () {
                            setState(() {
                              question =
                                  question.substring(0, (question.length) - 1);
                            });
                          },
                        );
                      } else if (mybuttons[index] == '=') {
                        return Buttons(
                          button: mybuttons[index],
                          text: Colors.black,
                          background: Colors.orange,
                          clicked: () {
                            setState(() {
                              equal();
                            });
                          },
                        );
                      } else if (mybuttons[index] == 'ANS') {
                        return Buttons(
                          button: mybuttons[index],
                          text: Colors.white,
                          background: Colors.black,
                          clicked: () {
                            setState(() {
                              question += answer;
                            });
                          },
                        );
                      } else {
                        return Buttons(
                            button: mybuttons[index],
                            text: isoperator(mybuttons[index])
                                ? Colors.black
                                : Colors.white,
                            background: isoperator(mybuttons[index])
                                ? Colors.orange
                                : Colors.black,
                            clicked: () {
                              setState(() {
                                question += mybuttons[index];
                              });
                            });
                      }
                    }),
              ))
        ],
      ),
    );
  }
}
