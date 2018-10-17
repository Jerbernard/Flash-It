import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'viewcard.dart';
import 'dart:async';
import 'dart:io';

class AddCard extends StatefulWidget {
  final TextStorage storage;

  AddCard({Key key, @required this.storage}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _SystemPadding extends StatelessWidget {
  final Widget child;
  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}

class _AddCardState extends State<AddCard> {
  TextEditingController _questionField = new TextEditingController();
  TextEditingController _answerField = new TextEditingController();

  String _content = '';
  int n = -1;
  List<String> _question = new List();
  List<String> _answer = new List();

  addQuestion(String text) {
    _question.add(text);
  }

  addAnswer(String text) {
    _answer.add(text);
    n++;
  }

  clearArray() {
    _question.clear();
    _answer.clear();
    n = -1;
  }

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _content = text;
      });
    });
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new _SystemPadding(
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: _answerField,
                  decoration: new InputDecoration(
                    labelText: 'Enter Answer',
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  _answerField.clear();
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('SAVE'),
                onPressed: () {
                  //_writeStringToTextFile(_questionField.text);
                  addQuestion(_questionField.text);
                  addAnswer(_answerField.text);
                  // _writeStringToTextFile(_answerField.text);
                  _writeStringToTextFile(_question[n]);
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content: new Text("New Card has been Added"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("Ok"),
                                onPressed: () {
                                  _writeStringToTextFile(_answerField.text);
                                  Navigator.pop(context);
                                  _questionField.clear();
                                  _answerField.clear();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => ViewCards(storage: TextStorage())),
                                   );
                                },
                              ),
                            ]);
                      });
                })
          ],
        ),
      ),
    );
  }

  Future<File> _writeStringToTextFile(String text) async {
    setState(() {
      _content += text;
    });
    return widget.storage.writeFile(text);
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _content = '';
    });
    return widget.storage.cleanFile();
  }

  @override
  Widget build(BuildContext context) {
    //int count = 0;
    String current;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Flashcard'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Text('Question: '),
            TextField(
              controller: _questionField,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                child: Text(
                  'Enter Answer',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueAccent,
                onPressed: _showDialog,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
