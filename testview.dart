import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'begintest.dart';

// Can be a Stateless Widget
// This page will be used to view decks and select which one to self test
// This page will also retrieve the decks and store them in separate arrays
// User chooses which one to pass into the selftest

// Class initialization
class TestCards extends StatefulWidget {
  final TextStorage storage;
  final String filename;
  TestCards({Key key, @required this.storage, this.filename}) : super(key: key);

  @override
  _TestCards createState() => _TestCards();
}

class _TestCards extends State<TestCards> {
  String _deckName;
  String filename;
  List<String> deck = [];
  List<String> deckSets = [];
  int deckCount = 0;
  String _ans;
  int n = 0;
  int i = 0;

  @override
  void initState() {
    super.initState();

    widget.storage.readFile().then((String text) {
      setState(() {
        _deckName = text; // pulls text from file
      });
      deckSets = _deckName.split('\n'); // split string to array
      deckCount++;
    });
  }

  // Widget for building app page
  // Will implement dynamic creation of buttons for every file that is created
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
              child: GestureDetector( 
                child: RaisedButton(
                  child: Text(
                    '${deckSets[0]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testSelf(deckSets[0]);
                  },
                ),
                onLongPress: () {
                  resultData();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: GestureDetector( 
                child: RaisedButton(
                  child: Text(
                    'Mathematics Cards', //${deckSets[0]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testSelf(deckSets[0]);
                  },
                ),
                onLongPress: () {
                  resultData();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: GestureDetector( 
                child: RaisedButton(
                  child: Text(
                    'Biology Cards', //${deckSets[0]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    testSelf(deckSets[0]);
                  },
                ),
                onLongPress: () {
                  resultData();
                },
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
              IconButton(
                icon: Icon(Icons.create),
                tooltip: 'Create a Flashcard',
                onPressed: () {
                  //createButton();
                },
              ),
              IconButton(
                icon: Icon(Icons.folder_open),
                tooltip: 'Manage Flashcards',
                onPressed: () {
                  //manageButton();
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

  testSelf(String deckNam) {
    widget.storage.readDeck(deckNam).then((String text) {
      setState(() {
        _ans = text; // pulls text from file
      });
      deck = _ans.split('\n'); // split string to array
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BeginTest(deck: deck, filename: deckNam)),
    );
  }

  resultData() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: new Text('You have scored a 100% 3/5 times on this deck!'),
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
  }

/*
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
          builder: (context) => ViewCard(storage: TextStorage(), filename:filename)),
    );
  }*/
}