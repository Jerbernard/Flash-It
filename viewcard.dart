import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'dart:async';
import 'dart:io';

class ViewCards extends StatefulWidget {
  final TextStorage storage;
  ViewCards({Key key, @required this.storage}) : super(key: key);

  @override
  _ViewCards createState() => _ViewCards();
}

class _ViewCards extends State<ViewCards> {
  List<String> _question;
  String _answer;
  final Set<String> _saved = new Set<String>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _answer = text; // pulls text from file
      });
      _question = _answer.split('\n'); // split string to array
    });
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _answer = '';
    });

    return widget.storage.cleanFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Flashcards'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
        backgroundColor: Colors.blue,
      ),
      body: _buildFlashCard(),
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
                                _clearContentsInTextFile();
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

  Widget _buildFlashCard() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        } else if (i + 1 != _question.length) {
          return _buildRow(_question[i], _question[i + 1]);
        }
      },
      itemCount: _question.length,
    );
  }

  Widget _buildAnswer(String answer, String question) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Answer: '),
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 85.0, right: 0.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Q: $question",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ), 
                Padding(
                  padding: EdgeInsets.only(left: 90.0, right: 90.0),
                  child: Text("\n\nA: $answer"),
                ), 
              ],
            ),
          ),
          bottomNavigationBar: new BottomAppBar(
            color: Colors.blue,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //bottom app functionality here
                IconButton(
                  icon: Icon(Icons.check), //save the current card
                  tooltip: 'Mark Flashcard',
                  onPressed: () { 
                              _saved.add(question);
                             Navigator.pop(context);
                              },
                ),
                IconButton(
                  icon: Icon(Icons.backspace), //return home
                  tooltip: 'back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildRow(String question, String answer) {
    final bool alreadySaved = _saved.contains(question);

    return new ListTile(
      title: new Text(
        '$question',
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.blue : null,
      ),
      onLongPress: (){
        setState(() {
          if (alreadySaved) {
            _saved.remove(question);
          } else {
            _saved.add(question);
           }
        });
      },
      onTap: () {
             _buildAnswer(answer, question);

      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // new page
      new MaterialPageRoute<void>(
        // create material
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (String question) {
              return new ListTile(
                title: new Text(
                  question.toString(), // print question
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Questions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
