import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'addcard.dart';
import 'testview.dart';
import 'dart:io';
import 'viewdeck.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController _name = new TextEditingController(); 
  TextStorage storage = new TextStorage(); 
  String filename; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashIt v0.1a'),
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
                      text: "FlashIt!",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 60.0,
                        fontStyle: FontStyle.italic,                    
                      )
                    ),
                  ),              
                ),//Flash it text
                Padding(
                  padding: EdgeInsets.only(left: 90.0, right: 90.0),
                  child: Text("How would you like to flash it?"),              
                ),//Add card b
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    child: Text(
                      'Create New Deck',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: ()  {
                      showDialog<String> (context: context, 
                      child: new AlertDialog(
                        contentPadding: const EdgeInsets.all(16),
                        
                        content: new Row(children: <Widget> [
                          new Expanded (
                            child: new TextField (
                              controller: _name,
                              decoration: new InputDecoration(
                              labelText: 'Enter Deck Name',)
                            ),
                            )
                        ],
                        ),
                      
                      actions: <Widget> [
                        new FlatButton (
                          child: const Text('CANCEL'),
                          onPressed:() {
                            _name.clear();
                            Navigator.pop(context);
                          }
                        ),
                        new FlatButton(
                          child:const Text('ENTER'),
                          onPressed: ()
                          {
                            filename = _name.text; 
                            storage.writeFile(filename);
                            _name.clear(); 
                            Navigator.pop(context); 
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddCard(storage: TextStorage(), filename:filename)),
                          );
                          })
                      ],
                      ),
                      );
                      },
                  ),         
                ),//Add card button
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    child: Text(
                      'Manage Flashcards',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewDecks(storage: TextStorage())),
                        );
                      },
                    ),              
                  ),//view button
                  Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    child: Text(
                      'Test Flashcards',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestCards(storage: TextStorage(), filename: filename)),
                        );
                      },
                    ),              
                  ),//edit button
                  Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    child: Text(
                      'Exit',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () => exit(0), 
                    ),              
                  ),//exit button
                ],
              ),
            ),
    );
  }
}
