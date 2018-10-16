
import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'dart:async';
import 'dart:io';

class AddCard extends StatefulWidget {
  final TextStorage storage;

  AddCard({Key key, @required this.storage}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
  
}

class _AddCardState extends State<AddCard> {
  TextEditingController _questionField = new TextEditingController();
  TextEditingController _answerField = new TextEditingController();

  String _content = '';
  int n = 0;
  List<String> _question = new List();
  List<String> _answer = new List();

  addQuestion(String text){
    _question.add(text); 
  }

  addAnswer(String text){
    _answer.add(text);
    n++;
  }

  clearArray(){
    _question.clear();
    _answer.clear();
    n = 0;
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
/*
  Future<File> _writeStringToTextFile(String text) async {
    setState(() {
      _content += text + '\r\n';
    });

    return widget.storage.writeFile(text);
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _content = '';
    });

    return widget.storage.cleanFile();
  }
*/
  @override
  Widget build(BuildContext context) {
    //int count = 0;
    //String current = _question[count];
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Flashcard'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _questionField,
            ),
            Text('Question'),
            TextField(
              controller: _answerField,
            ),
            Text('Answer'),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                child: Text(
                  'Clear Contents',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  clearArray();
                  //_clearContentsInTextFile();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                child: Text(
                  '${_question[n]}',
                  //'$current',
                  //'$_content',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
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
              onPressed: () {},
              ),

            IconButton(
              icon: Icon(Icons.save), //save the current card
              tooltip: 'Save Flashcard',
              onPressed: () {
                return showDialog(
                context: context,
                   builder: (context) {
                    return AlertDialog(
                      content: new Text(
                        "Would you like to save this flashcard?"),
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text("Yes"),
                                onPressed: () {
                                  if (_questionField.text.isNotEmpty && _answerField.text.isNotEmpty) {
                                    addQuestion(_questionField.text);
                                    addAnswer(_answerField.text);
                                    //_writeStringToTextFile('\n');
                                    _questionField.clear();
                                    _answerField.clear();
                                  }
                                  Navigator.pop(context);
                                return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: new Text(
                                        "Successfully added flashcard!"),
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
                icon: Icon(
                    Icons.delete_outline), //delete current card in progress
                tooltip: 'Delete current Flashcard',
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: new Text(
                              "Are you sure you would like to delete this flashcard?"),
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text("Yes"),
                                onPressed: () {
                                  //save here
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
          )),
    );
  }

}
