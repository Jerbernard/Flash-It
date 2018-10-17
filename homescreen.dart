
import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'addcard.dart';
import 'viewcard.dart';
import 'testcard.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
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
                      ),

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
                      'Create New Flashcard',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCard(storage: TextStorage())),
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
                            builder: (context) => ViewCards(storage: TextStorage())),
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
                            builder: (context) => TestCards(storage: TextStorage())),
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
