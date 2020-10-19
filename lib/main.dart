import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );

  }
}

class Calculator extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Calculator> {

  Widget buttons(String buttonText, Color buttonColor, Color textColor){
    return Container(
      child: RaisedButton(onPressed: (){
        calculatorOperations(buttonText);
      },
        child: Text('$buttonText',
        style: TextStyle(
          fontSize: 40,
          color: textColor,
        ),
        ),
        color: buttonColor,
        padding: EdgeInsets.all(20),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator'), backgroundColor: Colors.white10,),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(0),
                  child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                    fontSize: 90),
                ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttons('C', Colors.white24, Colors.white),
                buttons('+/-', Colors.white24, Colors.white),
                buttons('%', Colors.white24, Colors.white),
                buttons('÷', Colors.amber[700], Colors.white)
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttons('7', Colors.grey[600], Colors.white),
                buttons('8', Colors.grey[600], Colors.white),
                buttons('9', Colors.grey[600], Colors.white),
                buttons('x', Colors.amber[700], Colors.white)
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttons('4', Colors.grey[600], Colors.white),
                buttons('5', Colors.grey[600], Colors.white),
                buttons('6', Colors.grey[600], Colors.white),
                buttons('-', Colors.amber[700], Colors.white)
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttons('1', Colors.grey[600], Colors.white),
                buttons('2', Colors.grey[600], Colors.white),
                buttons('3', Colors.grey[600], Colors.white),
                buttons('+', Colors.amber[700], Colors.white)
              ],
            ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(32, 23, 128, 20),
                  onPressed: (){

                  },
                  child: Text('0',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white
                  ),
                  ),
                  color: Colors.grey[600],
                ),
                buttons('.', Colors.grey[600], Colors.white),
                buttons('=', Colors.amber[700], Colors.white),
              ],
            )

          ],
        ),
      ),
    );
  }

  dynamic text ='0';
  double firstNumber = 0;
  double secondNumber = 0;
  dynamic operation = '';
  dynamic operation1 = '';
  dynamic result = '';
  dynamic finalResult = '';

  void calculatorOperations(buttonText) {
    if(buttonText  == 'C') {
      text ='0';
      firstNumber = 0;
      secondNumber = 0;
      operation = '';
      operation1 = '';
      result = '';
      finalResult = '0';

    }

    else if( operation == '=' && buttonText == '=') {
      if(operation1 == '+') {
        finalResult = addition();
      } else if( operation1 == '-') {
        finalResult = subtraction();
      } else if( operation1 == 'x') {
        finalResult = multiply();
      } else if( operation1 == '÷') {
        finalResult = divide();
      }
    }

    else if(buttonText == '%') {
      result = firstNumber / 100;
      finalResult = haveDecimalNumber(result);
    }
    else if(buttonText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    else if(buttonText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;
    }

    else if(buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '÷' || buttonText == '=') {
      if(firstNumber == 0) {
        firstNumber = double.parse(result);
      } else {
        secondNumber = double.parse(result);
      }

      if(operation == '+') {
        finalResult = addition();
      } else if( operation == '-') {
        finalResult = subtraction();
      } else if( operation == 'x') {
        finalResult = multiply();
      } else if( operation == '÷') {
        finalResult = divide();
      }
      operation1 = operation;
      operation = buttonText;
      result = '';
    }

    else {
      result = result + buttonText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });

  }

  String haveDecimalNumber(dynamic result) {
    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

  String addition() {
    result = (firstNumber + secondNumber).toString();
    firstNumber = double.parse(result);
    return haveDecimalNumber(result);
  }

  String subtraction() {
    result = (firstNumber - secondNumber).toString();
    firstNumber = double.parse(result);
    return haveDecimalNumber(result);
  }
  String multiply() {
    result = (firstNumber * secondNumber).toString();
    firstNumber = double.parse(result);
    return haveDecimalNumber(result);
  }
  String divide() {
    result = (firstNumber / secondNumber).toString();
    firstNumber = double.parse(result);
    return haveDecimalNumber(result);
  }
}
