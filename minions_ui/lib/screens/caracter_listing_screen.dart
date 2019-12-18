import 'package:flutter/material.dart';
import 'package:minions_ui/styles.dart';
import 'package:minions_ui/widgets/character_widget.dart';


class CaracterListingPage extends StatefulWidget {
  @override
  _CaracterListingPageState createState() => _CaracterListingPageState();
}

class _CaracterListingPageState extends State<CaracterListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 10.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'Despicable Me',style: AppTheme.display1),
                    TextSpan(text: '\n'),
                    TextSpan(text: 'Characters', style: AppTheme.display2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Caracter(),
            ),
                    SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}