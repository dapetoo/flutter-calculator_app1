import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String strInput = "";
final textControllerInput = TextEditingController();
final textControllerResult = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Text("Calculator",
          // style: TextStyle(backgroundColor: Colors.red),),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: "Enter Number",
                    hintStyle: TextStyle(
                      fontSize: 10,
                    )),
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                textAlign: TextAlign.right,
                controller: textControllerInput,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoMono',
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              // decoration: InputDecoration.collapsed(
              //   // hintText: "Result",
              //   // hintStyle: TextStyle(
              //   //   fontSize: 30,
              //   //   fontFamily: 'RobotoMono',
              //   // ),
              // ),
              controller: textControllerResult,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.none,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
          ),

          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnAC("AC", const Color(0xFFF5F7F9)),
              btnClear(),
              btn(
                '%',
                const Color(0xFFF5F7F9),
              ),
              btn(
                '/',
                const Color(0xFFF5F7F9),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn("7", Colors.white),
              btn("8", Colors.white),
              btn("9", Colors.white),
              btn(
                "*",
                const Color(0xFFF5F7F9),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn("4", Colors.white),
              btn("5", Colors.white),
              btn("6", Colors.white),
              btn(
                '-',
                const Color(0xFFF5F7F9),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn("1", Colors.white),
              btn("2", Colors.white),
              btn("3", Colors.white),
              btn('+', const Color(0xFFF5F7F9))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn("0", Colors.white),
              btn(".", Colors.white),
              btnEqual('='),
            ],
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  Widget btn(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = textControllerInput.text + btntext;
          });
        },
        color: btnColor,
        //padding: EdgeInsets.all(10.0),
        //splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnClear() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey),
        onPressed: () {
          textControllerInput.text = (textControllerInput.text.length > 0)
              ? (textControllerInput.text
                  .substring(0, textControllerInput.text.length - 1))
              : "";
        },
        color: const Color(0xFFF5F7F9),
        padding: EdgeInsets.all(18.0),
        //splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = "";
            textControllerResult.text = "";
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        //splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnEqual(btnText) {
    return GradientButton(
      child: Text(
        btnText,
        style: TextStyle(fontSize: 35.0),
      ),
      increaseWidthBy: 50.0,
      increaseHeightBy: 15.0,
      callback: () {
        //Calculate everything here
        // Parse expression:
        Parser p = new Parser();
        // Bind variables:
        ContextModel cm = new ContextModel();
        Expression exp = p.parse(textControllerInput.text);
        setState(() {
          textControllerResult.text =
              exp.evaluate(EvaluationType.REAL, cm).toString();
        });
      },
      gradient: Gradients.jShine,
    );
  }
}
