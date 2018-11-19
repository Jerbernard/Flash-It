import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'dart:async';
import 'dart:io';
import 'testcard.dart';
import 'viewdeck.dart';

// Self test on this page
// Receive results on this page

class BeginTest extends StatefulWidget {
  final List<String> deck;
  final String filename;
  BeginTest({Key key, @required this.deck, @required this.filename}) : super(key: key);

  @override
  _BeginTest createState() => new _BeginTest();
}

class _BeginTest extends State<BeginTest> {
  int n = 0;
  int size = 0;
  int result = 0;
  String filename;

  List<String> questions = [];
  List<String> answers = [];

  void initState() {
    super.initState();
    for (int i = 0; i < widget.deck.length - 1; i++) {
      print('${widget.deck[i]}\n');
      if (i % 2 == 0) {
        questions.add(widget.deck[i]);
        size++;
      } else {
        answers.add(widget.deck[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck 1'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            prompts(widget.deck),
            Padding(
              padding: EdgeInsets.only(),
              child: RaisedButton(
                  child: Text(
                    'Exit Quiz',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    // If user would like to exit self test
                    exitButton();
                  }),
            ),
          ],
        ),
      ),
    );
  }
  exitButton() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text('Are you sure you want to leave?'),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    //save here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TestCards(storage: TextStorage())),
                    );
                  }),
              new FlatButton(
                  child: new Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]);
      },
    );
  }

  // Function call for revealing answer dialog
  answerButton() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text('Answer: ${answers[n]}'),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Got it!"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ]);
      },
    );
  }

  // Function call for pressing next question
  nextButton() {
      setState(() {
        n += 1;
        result += 1;
      });
      prompts(widget.deck);
  }
  

  prompts(deck) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title:Text("Question: ${n + 1}")
          ),
          new ListTile(
            title: Text('${questions[n]}'),
            subtitle: Text('whats your answer?'),
          ),
          new Divider(color: Colors.blue, indent: 100.0),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.clear),
                  onPressed: () {
                    if (n == size - 1) {
                      results();
                      
                    }
                    else{
                    setState(() {
                      n += 1;
                    });
                    }
                  },
                ),
                FlatButton(
                  child: Text('Reveal Answer'),
                  onPressed: () {
                    answerButton();
                  },
                ),
                FlatButton(
                  child: Icon(Icons.check),
                  onPressed: () {
                    if (n == size - 1) {
                      result++;
                      results();
                      print('display results');
                    }
                    else{
                      nextButton();
                      print('next question');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  results() {
    double percentage = (result / (size))*100;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: new Text("You score is..." "$percentage percent!\n"
            "Or $result/$size"
            ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Thanks!"),
                  onPressed: () {
                    //save here
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
            ]);
      },
    );
  }
}
