import 'package:flutter/material.dart';
import 'addcard.dart';
import 'textstorage.dart';
import 'dart:async';
import 'dart:io';

class ViewCards extends StatelessWidget {
  List<String> qcards;
  List<String> acards;
  //int da;
  ViewCards([this.qcards, this.acards]);
  //ViewCards.empty();
  
  String _question = '';
  String _answer = '';
  //AddCardState cards = new AddCardState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('View Flashcards'),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                child: new Text(
                  //'$_question',
                  '${this.qcards}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            Text('${this.acards}'),
          ],
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.blue,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //bottom app functionality here
            IconButton(
              icon: Icon(Icons.question_answer),
              tooltip: 'Flip Flashcard',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCard(storage: TextStorage())),
                  );},
            ),

            IconButton(
              icon: Icon(Icons.save), //save the current card
              tooltip: 'Save Flashcard',
              onPressed: () {},
            ),

            IconButton(
              icon:
                  Icon(Icons.delete_forever), //delete current card in progress
              tooltip: 'Delete current Flashcard',
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: new Text(
                            "Are you sure you would like to delete all flashcards?"),
                        actions: <Widget>[
                          new FlatButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                //save here
                                //_clearContentsInTextFile();
                                Navigator.pop(context);
                              }),
                          new FlatButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ]);
                  },
                );
              },
            ),

            IconButton(
              icon: Icon(Icons.home), //return home
              tooltip: 'Home',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
