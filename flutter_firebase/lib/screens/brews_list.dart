import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brews[index]);
      },
    );
  }
}

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile(this.brew);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],           
          ),
          title: Text(brew.name),
          subtitle: Text(brew.sugras),
        ),
      ),
    );
  }
}
