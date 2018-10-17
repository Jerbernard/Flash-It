import 'package:flutter/material.dart';
import 'addcard.dart';
import 'textstorage.dart';
import 'viewcard.dart';

class TestCard extends StatelessWidget {
  List<String> qcards = new List();
  List<String> acards = new List();
  int n = 0;
  TestCard([this.qcards, this.acards]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
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
                  'Press me!',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: (){
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: Text(
                            'Number ${n+1} \nQ: ${qcards[n]}',
                            style: TextStyle(),
                          ), 
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text("Answer"),
                                onPressed: () {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          content: Text(
                                              'A: ${acards[n]}'),
                                          actions: <Widget>[
                                            new FlatButton(
                                                child: new Text("Ok"),
                                                onPressed: () {
                                                  //save here
                                                  Navigator.pop(context);
                                                }),
                                          ]);
                                    },
                                  );
                                }),
                            new FlatButton(
                                child: new Text("Next"),
                                onPressed: () {
                                  n++;
                                  Navigator.pop(context);
                                }),
                          ]);
                    },
                  );
                }
              ),
            ), //exit button
          ],
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
          color: Colors.blue,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.create),
                tooltip: 'Create a Flashcard',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCard(storage: TextStorage())),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.folder_open),
                tooltip: 'Manage Flashcards',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewCards(qcards, acards)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.school),
                tooltip: 'Test Flashcards',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
