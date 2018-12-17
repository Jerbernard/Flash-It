import 'package:flutter/material.dart';


class HelpScreen extends StatelessWidget {
  TextEditingController _name = new TextEditingController(); 
  String filename; 
  Brightness brightness;
  final TextStyle _biggerFont = const TextStyle(fontSize: 20.0);
  List<String> _questions = ["Q: How do i create a deck?",
                            "Q:  How do I get rid of old flash cards?", 
                            "Q:  How do I add a flash card to an existing deck?",
                            "Q:  How do I test myself?"
                            ];
  
  List<String> _answers = ["A:  First, press \"Create New Deck\" from the main menu.  Then, type a name for the deck.  Then, enter the first flash card!",
                          "A: Press \"Manage Flashcards\".  Then, select the deck you wish to delete. Next, press the delete icon.",
                          "A:  Press \"Manage Flashcards\".  Select the deck you wish to add to, then press the plus icon to add new cards to the selected deck.",
                          "A: Press the \"Test Flashcards\" button.  Then, select the deck you wish to review.  All cards in that deck will then appear, and you can confirm that you passed or failed each card."
                          ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        backgroundColor: Colors.blue,
      ),
      body: _buildFAQ()
    );


  }

  Widget _buildFAQ() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i != _questions.length) {
           return _buildRow(_questions[i], _answers[i]);
        }
      },
      itemCount: _questions.length,
    );
  }

  Widget _buildRow(String question, String answer) {
    return new ListTile(
      title: new Text(
        '$question',
        style: _biggerFont,
      ),
      onTap: () {
        _buildAnswer(answer, question);
      },
    );
  }

  Widget _buildAnswer(String answer, String question) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Answer: '),
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
                      text: "Q: $question",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 90.0, right: 90.0),
                  child: Text("\n\nA: $answer"),
                ),
              ],
            ),
          ),
          bottomNavigationBar: new BottomAppBar(
            color: Colors.blue,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //bottom app functionality here
                IconButton(
                  icon: Icon(Icons.backspace), //return home
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  
}
