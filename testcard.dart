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
  List<String> _qcards;
  List<String> _acards;
  String _ans;
  int n = 0;
  int i = 0;
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
/*
  void _assignArray() {
    for (int i = 0; i < _cards.length; i++) {
      if (i.isOdd) {
        _qcards.add(_cards[i]);
      } else if (i.isEven) {
        _acards.add(_cards[i]);
      }
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    //_assignArray();
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content: Text(
                              'Number ${i} \nQ: ${_cards[n]}',
                              style: TextStyle(),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                  child: new Text("Prev"),
                                  onPressed: () {
                                    i -= 1;
                                    n -= 2;
                                    Navigator.pop(context);
                                  }),
                              new FlatButton(
                                  child: new Text("Answer"),
                                  onPressed: () {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            content: Text('A: ${_cards[n+1]}'),
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
                                    i += 1;
                                    n += 2;
                                    Navigator.pop(context);
                                  }),
                            ]);
                      },
                    );
                  }),
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
                        builder: (context) =>
                            ViewCards(storage: TextStorage())),
                  );
                },
              ),
            ],
          )),
    );
  }
}