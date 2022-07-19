import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: "Calculator",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String equation="0";
  String result = "0";
  String expression ="";
  double equationFontSize=38.0;
  double resultFontSize=48.0;
  @override
  Widget build(BuildContext context) {
    buttonPressed(String text ){
      print(text);
      setState(() {
        if(text=="C")
        {
          equation="0";
          result="0";
          equationFontSize=38.0;
          resultFontSize=48.0;

        }
        else if(text=="⊲")
        {
          equation=equation.substring(0,equation.length-1);
          if(equation=="") {
            equation = "0";
            equationFontSize=38.0;
            resultFontSize=48.0;

          }
        }
        else if(text=="=")
        {
          equationFontSize=30.0;
          resultFontSize=48.0;
          expression=equation;
          expression=expression.replaceAll('×', '*');
          expression=expression.replaceAll('÷', '/');
          try {

            Parser parser = Parser();
            Expression exp = parser.parse(expression);
            ContextModel cm=ContextModel();
            result='${exp.evaluate(EvaluationType.REAL, cm)}';
          }
          catch (e){
            print(e.toString());
            result="Erorr";
          }

        }
        else
        {
          equationFontSize=48.0;
          resultFontSize=38.0;

          if(equation=="0")
          {
            equation=text;
          }
          else
            equation+=text;
        }
        print(equation);
        print(result);
      });
    }

    Container buildElement(double height, String text, Color color,) {

      return Container(
        height: MediaQuery.of(context).size.height * 0.1 * height,
        color: color,
        child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.all(16)),
              shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid,
                      )))),
          onPressed: ()=>buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      );
    }



    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildElement(1, "C", Colors.redAccent),
                      buildElement(1, "⊲", Colors.blue),
                      buildElement(1, "÷", Colors.blue),
                    ]),
                    TableRow(children: [
                      buildElement(1, "7", Colors.black54),
                      buildElement(1, "8", Colors.black54),
                      buildElement(1, "9", Colors.black54),
                    ]),

                    TableRow(children: [
                      buildElement(1, "4", Colors.black54),
                      buildElement(1, "5", Colors.black54),
                      buildElement(1, "6", Colors.black54),
                    ]),
                    TableRow(children: [
                      buildElement(1, "1", Colors.black54),
                      buildElement(1, "2", Colors.black54),
                      buildElement(1, "3", Colors.black54),
                    ]),
                    TableRow(children: [
                      buildElement(1, ".", Colors.black54),
                      buildElement(1, "0", Colors.black54),
                      buildElement(1, "00", Colors.black54),
                    ]),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildElement(1, '×', Colors.blue),
                    ]),
                    TableRow(children: [
                      buildElement(1, '+', Colors.blue),
                    ]),
                    TableRow(children: [
                      buildElement(1, '-', Colors.blue),
                    ]),

                    TableRow(children: [
                      buildElement(2, '=', Colors.redAccent),
                    ])
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
