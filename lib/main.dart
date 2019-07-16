import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'src/question_bank.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> resultbar = [];
  Questions qBank = Questions();

  void onPressed() {
    setState(() {
      qBank.resetIndex();
      resultbar = [];
      Navigator.pop(context);
    });
  }

  void increaseIndex(bool type, BuildContext context) {
    setState(() {
      if (qBank.show()) {
        if (qBank.getAnswer() == type) {
          resultbar.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          resultbar.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      } else {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Finished",
          closeFunction: () {
            setState(() {
              qBank.resetIndex();
              resultbar = [];
            });
          },
          desc: "You have completed the challengr",
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: onPressed,
              width: 120,
            )
          ],
        ).show();
      }
      qBank.increaseIndex();
    });
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qBank.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                increaseIndex(true, context);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                increaseIndex(false, context);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: resultbar,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
