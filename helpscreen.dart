import 'package:flutter/material.dart';


class HelpScreen extends StatelessWidget {
  TextEditingController _name = new TextEditingController(); 
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                SingleChildScrollView(
                scrollDirection: Axis.vertical,
                  
                child:ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),

                children: <Widget>[

                  Padding(//FlashIt! text
                    padding: EdgeInsets.only(left: 140.0, right: 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: "FAQ's",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30.0,
                          fontStyle: FontStyle.normal,                    
                        )
                      ),
                    ),              
                  ),//FAQs
                           
                  Text("\nQ:  How do I create a deck?\nA:  First, press \"Create New Deck\" from the main menu.  Then, type a name for the deck.  Then, enter the first flash card! "),            
                  Text("\nQ:  How do I get rid of old flash cards?\nA: Press \"Manage Flashcards\".  Then, select the deck you wish to delete. Next, press the delete icon. "),
                  Text("\nQ:  How do I add a flash card to an existing deck?\nA:  Press \"Manage Flashcards\".  Select the deck you wish to add to, then press the plus icon to add new cards to the selected deck."),
                  Text("\nQ:  How do I add a flash card to an existing deck?\nA:  Press \"Manage Flashcards\".  Select the deck you wish to add to, then press the plus icon to add new cards to the selected deck."),
                  Text("\nQ:  How do I test myself?\nA: Press the \"Test Flashcards\" button.  Then, select the deck you wish to review.  All cards in that deck will then appear, and you can confirm that you passed or failed each card."),
                ],
                )
                ),      
                ],
              ),
            ),
    );
  }
}
