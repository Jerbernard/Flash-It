import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'viewcard.dart';

class AddCard extends StatefulWidget {
  final TextStorage storage;

  AddCard({Key key, @required this.storage}) : super(key: key);

  @override
  AddCardState createState() => AddCardState();
}

class AddCardState extends State<AddCard> {
  TextEditingController _questionField = new TextEditingController();
  TextEditingController _answerField = new TextEditingController();

  String _content = '';
  int n = 0;
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
    n = 0;
  }

  String printCard(){//String _question, String _answer){
    for(int i = 0; i < n; i++){
      print('${_question[i]} ');
      print('${_answer[i]}\n');
    }
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
            Row(children: <Widget>[
              Expanded(
                child: Text(
                  '$_question')),
              Expanded(
                child: Text(
                  '$_answer'),
              )
            ]),
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
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: Text(
                            '${_question[0]}${_question[1]}${_question[2]}\n${_answer[0]}${_answer[1]}${_answer[2]}',
                              ),
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
                },
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
                                  if (_questionField.text.isNotEmpty &&
                                      _answerField.text.isNotEmpty) {
                                    addQuestion(_questionField.text);
                                    addAnswer(_answerField.text);
                                    _questionField.clear();
                                    _answerField.clear();
                                    new MaterialPageRoute(
                                      builder: (context) => new ViewCards(_question, _answer),
                                    );
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
