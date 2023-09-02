import 'package:calculator/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userQuestion = "";
  var userAnswer = "";
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink.shade400, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 79, 79, 79)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userAnswer,
                        style: GoogleFonts.montserrat(
                            fontSize: 25, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                      itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                          buttonTapped: () {
                            userQuestion = "";
                            setState(() {});
                          },
                          buttonText: buttons[index],
                          color: Colors.green,
                          textColor: Colors.white);
                    }
                    if (index == 1) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.white);
                    }
                    if (index == buttons.length - 1) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.purpleAccent,
                          textColor: Colors.white);
                    } else {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion + buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.purpleAccent
                              : Colors.pink,
                          textColor: Colors.white);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "/" || x == "-" || x == "+" || x == "*" || x == "=" || x == "%") {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
