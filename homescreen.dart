import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'textstorage.dart';
import 'addcard.dart';
import 'testview.dart';
import 'dart:io';
import 'dart:async';
import 'viewdeck.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) => MaterialApp(
          theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
          home: HomeScreen(snapshot.data)),
    );
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();

class HomeScreen extends StatelessWidget {
  final TextEditingController _name = new TextEditingController();
  final TextStorage storage = new TextStorage();
  String filename;
  bool themeValue = false;

  var _element;
  BuildContext get context => _element;

  final bool darkThemeEnabled;
  HomeScreen(this.darkThemeEnabled);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashIt v2.0'),
      ),

      // Drawer at the top left of the app
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: RichText(
                text: TextSpan(
                    text: "Settings",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontStyle: FontStyle.italic,
                    )),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dark Theme'),
              trailing: Switch(
                  value: darkThemeEnabled,
                  onChanged: bloc.changeTheme,     
              ),
              
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('FAQS'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // Body of the page
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 65.0, right: 0.0),
              child: RichText(
                text: TextSpan(
                    text: "FlashIt!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 60.0,
                      fontStyle: FontStyle.italic,
                    )),
              ),
            ), //Flash it text

            Padding(
              padding: EdgeInsets.only(left: 65.0, right: 50.0),
              child: Text("How would you like to flash it?\n\n"),
            ), //Add card b

            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                child: Text(
                  'Create New Deck',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    child: new AlertDialog(
                      contentPadding: const EdgeInsets.all(16),
                      content: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                                controller: _name,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Deck Name',
                                )),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              _name.clear();
                              Navigator.pop(context);
                            }),
                        new FlatButton(
                            child: const Text('ENTER'),
                            onPressed: () {
                              filename = _name.text;
                              storage.writeFile(filename);
                              _name.clear();
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCard(
                                        storage: TextStorage(),
                                        filename: filename)),
                              );
                            })
                      ],
                    ),
                  );
                },
              ),
            ), //Add card button
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
                        builder: (context) =>
                            ViewDecks(storage: TextStorage())),
                  );
                },
              ),
            ), //view button
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
                        builder: (context) => TestCards(
                            storage: TextStorage(), filename: filename)),
                  );
                },
              ),
            ), //edit button
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
            ), //exit button
          ],
        ),
      ),
    );
  }
}
  
  
