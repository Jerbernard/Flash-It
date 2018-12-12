import 'package:flutter/material.dart';
import 'textstorage.dart';
import 'addcard.dart';
import 'viewcard.dart';
import 'testview.dart';
import 'dart:io';
import 'viewdeck.dart';
import 'helpscreen.dart';


class HomeScreen extends StatelessWidget {
  TextEditingController _name = new TextEditingController(); 
  TextStorage storage = new TextStorage(); 
  String filename; 
  Brightness brightness;
  

  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashIt v2.0'),
      ),
      body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Padding(//FlashIt! text
                  padding: EdgeInsets.only(left: 65.0, right: 0.0),
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
                ),//FlashIt! text

                Padding(
                  padding: EdgeInsets.only(left: 65.0, right: 50.0),
                  child: Text("\nHow would you like to flash it?\n"),              
                ),//Text Padding

                Padding(//Create new deck
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    child: Text(
                      'Create New Deck',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: ()  {
                      showDialog<String> (context: context, 
                      child: new AlertDialog( //pop up box prompt
                        contentPadding: const EdgeInsets.all(16.0),
                        
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
                ),//Create Deck Button

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
                  ),//Flashcard Managing Button

                  Padding(//flashcard testing
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
                  ),//test button

                  Padding(//help 
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    child: Text(
                      'Help',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HelpScreen()),
                        );
                      },
                    ),              
                  ),//help button
                
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
