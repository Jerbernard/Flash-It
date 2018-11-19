import 'package:flutter/material.dart';
import 'addcard.dart';
import 'textstorage.dart';
import 'viewcard.dart';
import 'begintest.dart';

// Can be a Stateless Widget
// This page will be used to view decks and select which one to self test
// This page will also retrieve the decks and store them in separate arrays
// User chooses which one to pass into the selftest 

// Class initialization
class TestCards extends StatefulWidget {
  final TextStorage storage;
  TestCards({Key key, @required this.storage}) : super(key: key);

  @override
  _TestCards createState() => _TestCards();
}

// Global to allow deck to be passed to self test screen
// List<String> deck;

class SendDeck{
  final List<String> deck;
  SendDeck(this.deck);
}

class _TestCards extends State<TestCards> {
  List<String> deck;
  String _ans;
  int n = 0;
  int i = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _ans = text; // pulls text from file
      });
      deck = _ans.split('\n'); // split string to array
    });
  }

  // Widget for building app page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a deck'),
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
                    'Deck 1',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testSelf();
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: RaisedButton(
                  child: Text(
                    'Deck 2',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testSelf();
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: RaisedButton(
                  child: Text(
                    'Deck 3',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testSelf();
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
                  createButton();
                },
              ),
              IconButton(
                icon: Icon(Icons.folder_open),
                tooltip: 'Manage Flashcards',
                onPressed: () {
                  manageButton();
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

  
  testSelf(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BeginTest(deck: deck)),
    );
  }

  // Function call to initialize self testing
  testSelff() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(
              'Number ${i + 1} \nQ: ${deck[n]}',
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

  createButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCard(storage: TextStorage())),
    );
  }

  manageButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewCards(storage: TextStorage())),
    );
  }
}
