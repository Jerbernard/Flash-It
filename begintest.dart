import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'dart:async';
import 'dart:io';
import 'testcard.dart';

// Self test on this page
// Receive results on this page

class BeginTest extends StatefulWidget {
  final List<String> deck;
  BeginTest({Key key, @required this.deck}) : super(key: key);

  @override
  _BeginTest createState() => new _BeginTest();
}

class _BeginTest extends State<BeginTest> {
  int n = 0;
  int size = 0;
  double result = 0;

  List<String> questions = [];
  List<String> answers = [];

  void initState() {
    super.initState();
    for (int i = 0; i < widget.deck.length - 1; i++) {
      if (i % 2 == 0) {
        questions.add(widget.deck[i]);
        size++;
      } else {
        answers.add(widget.deck[i]);
        size++;
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
                    'Get me out of here!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    exitButton();
                  }),
            ),
          ],
        ),
      ),
    );
  }
/*
  // Begin Test
  testButton() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(
              'Number ${n + 1} \nQ: ${questions[n]}',
              style: TextStyle(),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Prev"),
                  onPressed: () {
                    prevButton();
                  }),
              new FlatButton(
                  child: new Text("Answer"),
                  onPressed: () {
                    answerButton();
                  }),
              new FlatButton(
                  child: new Text("Next"),
                  onPressed: () {
                    nextButton();
                  }),
            ]);
      },
    );
  }
*/
  // If user would like to exit self test
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
    if (n == size - 1) {
      //Navigator.pop(context);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: new Text("This is the last card!"),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Sorry!"),
                    onPressed: () {
                      //save here
                      Navigator.pop(context);
                    }),
              ]);
        },
      );
    } else {
      setState(() {
        n += 1;
        result += 1;
      });
      prompts(widget.deck);
    }
  }

/*
  // Function call for pressing previous question already answered
  prevButton() {
    if (n <= 1) {
      Navigator.pop(context);
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: new Text("This is the first card!"),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Sorry!"),
                    onPressed: () {
                      //save here
                      Navigator.pop(context);
                    }),
              ]);
        },
      );
    } else {}
    Navigator.pop(context);
  }
*/

  prompts(deck) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
                    setState(() {
                      n += 1;
                    });
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
                      results();
                    }
                    nextButton();
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
    double percentage = result / size;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: new Text("You score is..."),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("$percentage"),
                  onPressed: () {
                    //save here
                    Navigator.pop(context);
                  }),
            ]);
      },
    );
  }
}
