import 'package:flutter/material.dart';
import 'addcard.dart';
import 'textstorage.dart';
import 'viewcard.dart';
import 'dart:async';
import 'dart:io';

class TestCards extends StatefulWidget {
  final TextStorage storage;
  TestCards({Key key, @required this.storage}) : super(key: key);

  @override
  _TestCards createState() => _TestCards();
}

class _TestCards extends State<TestCards> {
  List<String> _cards;
  String _ans;
  int n = 0;
  final Set<String> _saved = new Set<String>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _ans = text; // pulls text from file
      });
      _cards = _ans.split('\n'); // split string to array
    });
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _ans = '';
    });

    return widget.storage.cleanFile();
  }  


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
                            'Number ${n+1} \nQ: ${_cards[n]}',
                            style: TextStyle(),
                          ), 
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text("Prev"),
                                onPressed: () {
                                  n--;
                                  Navigator.pop(context);
                                }),
                            new FlatButton(
                                child: new Text("Answer"),
                                onPressed: () {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          content: Text(
                                              'A: ${_ans}'),
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
                        builder: (context) => ViewCards(storage: TextStorage())),
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
