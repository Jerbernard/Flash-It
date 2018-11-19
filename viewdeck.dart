import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'dart:async';
import 'dart:io';
import 'addcard.dart';
import 'viewcard.dart';

class ViewDecks extends StatefulWidget {
  final TextStorage storage;
  ViewDecks({Key key, @required this.storage}) : super(key: key);

  @override
  _ViewDecks createState() => _ViewDecks();
}

class _ViewDecks extends State<ViewDecks> {
  List<String> _card;
  List<String> _deck;
  String _deckName;  
  String _file;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _deckName = text;                       // pulls text from file
      });
      _deck = _deckName.split('\n');            // split string to array
    });
  }

  Future<File> _clearContentsInTextFile() async {
    setState(() {
      _file = '';
    });

    return widget.storage.cleanFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Flashcards'),
        actions: <Widget>[
          //new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
        backgroundColor: Colors.blue,
      ),
      body: _buildDecks(),
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
              icon: Icon(Icons.save),                 //save the current card
              tooltip: 'Save Flashcard',
              onPressed: () {},
            ),

            IconButton(
              icon:
                  Icon(Icons.delete_forever),         //delete current card in progress
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
              icon: Icon(Icons.plus_one), //return home
              tooltip: 'Addcard',
              onPressed: () {
                
                    Navigator.pop(context);
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCard(storage: TextStorage())),
                  );
                  
              },
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildDecks() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {

          if (i != _deck.length) {
          Divider(); 
          return _buildDeckRow(_deck[i]);
        }
      },
      itemCount: _deck.length,
    );
  }

    Widget _buildDeckRow(String deckName)
  { 
    return new ListTile(
      title: new Text(
        '$deckName',
        style: _biggerFont,
      ),
      onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewCard(storage: TextStorage(), filename:'max')),                 //HARDCODE NAME HERE !!!!!!!!!!!!!!!!!!
                                                   //would have to build flashcards here? make a new scaffold? a new page? team?
      );  
      }
      );
    }
}
