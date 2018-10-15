import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    title: 'FlashIt',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashIt'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp(storage: TextStorage())),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.folder_open),
                tooltip: 'Manage Flashcards',
                onPressed: () {},
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
}

class TextStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/text.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeFile(String text) async {
    final file = await _localFile;
    return file.writeAsString('$text\r\n', mode: FileMode.append);
  }

  Future<File> cleanFile() async {
    final file = await _localFile;
    return file.writeAsString('');
  }
}

class MyApp extends StatefulWidget {
  final TextStorage storage;

  MyApp({Key key, @required this.storage}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textField = new TextEditingController();

  String _content = '';

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String text) {
      setState(() {
        _content = text;
      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read/Write File Example'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textField,
            ),

            /* Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: RaisedButton(
                child: Text(
                  'Clear Contents',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.redAccent,
                onPressed: () {
                  _clearContentsInTextFile();
                },
              ),
            ),*/
            Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                child: Text(
                  '$_content',
                  style: TextStyle(
                    color: Colors.blue,
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
                                  if (_textField.text.isNotEmpty) {
                                    _writeStringToTextFile(_textField.text);
                                    _textField.clear();
                                  }
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
