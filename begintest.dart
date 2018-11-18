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
  // refer: https://stackoverflow.com/questions/30274107/how-can-a-missing-concrete-implementation-warning-be-suppressed 

  @override
  _BeginTest createState() => new _BeginTest();
}

class _BeginTest extends State<BeginTest> {
  int n = 0;
  int i = 0;
  
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
            Padding(
              padding: EdgeInsets.only(),
              child: RaisedButton(
                  child: Text(
                    'Are you ready?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testButton();
                  }),
            ),
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

  // Replace showDialog with a better "test" friendly interface
  testButton(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(
              'Number ${i + 1} \nQ: ${widget.deck[n]}',
              style: TextStyle(),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Prev"),
                  onPressed: () {
                    //prevButton();
                  }),
              new FlatButton(
                  child: new Text("Answer"),
                  onPressed: () {
                    //answerButton();
                  }),
              new FlatButton(
                  child: new Text("Next"),
                  onPressed: () {
                    //nextButton();
                  }),
            ]);
      },
    );
  }

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
}
