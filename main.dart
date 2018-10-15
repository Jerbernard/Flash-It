import 'package:flutter/material.dart';

void main() {
   runApp(
      MaterialApp(
      title: 'FlashIt',
      home: FirstScreen(),
    )
   );
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
                    MaterialPageRoute(builder: (context) => MyCustomForm()),
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
            )
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
        title: Text('Creating Flashcard (Front):'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),  
      ),

 // BOTTOM NAVIGATION BAR MANAGEMENT
      bottomNavigationBar: new BottomAppBar(
            color: Colors.blue,

            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[       //bottom app functionality here
                IconButton(
                  icon: Icon(Icons.question_answer),

                  onPressed: () {   
                      return showDialog(
                      context: context,
                      
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the user has typed in using our
                          // TextEditingController
                          content: Text(myController.text),
                        );
                      },
                    ); 
                  },
                ),

                IconButton(
                  icon: Icon(Icons.save),   //save the current card
                  tooltip: 'Save Flashcard',
                  onPressed: () {
                    return showDialog(
                      context: context,
                      
                      builder: (context) {
                        return AlertDialog(

                          content: new Text("Would you like to save this flashcard?"),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                            ),

                            new FlatButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                            )
                            
                          ]
                        );
                      },
                    ); 
                  },
                ),

                IconButton(
                  icon: Icon(Icons.delete_outline), //delete current card in progress
                  tooltip: 'Delete current Flashcard',
                  onPressed: () {
                    return showDialog(
                      context: context,
                      
                      builder: (context) {
                        return AlertDialog(
                          
                          content: new Text("Are you sure you would like to delete this flashcard?"),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                            ),

                            new FlatButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                            )
                            
                          ]
                        );
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
             )
        ),
    );
  }
}
