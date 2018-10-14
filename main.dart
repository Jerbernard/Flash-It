import 'package:flutter/material.dart';

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
                  icon: Icon(Icons.add),
                  onPressed: () {
                       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCustomForm()),
            );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.search),
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

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}





class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class will hold the data related to
// our Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Card Side A:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
        
      ),
 // BOTTOM NAVIGATION BAR MANAGEMENENT
      bottomNavigationBar: new BottomAppBar(
            color: Colors.blue,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.question_answer),
                  onPressed: () {   return showDialog(
            context: context,
            
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController
                content: Text(myController.text),
              );
            },
          ); },
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {Navigator.pop(context);},
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () { Navigator.pop(context);},
                ),
              ],
            )),
    );
  }
}
