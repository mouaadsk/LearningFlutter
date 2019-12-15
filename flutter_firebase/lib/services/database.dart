import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';

class DatabaseService {

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  final String uid;
  DatabaseService({this.uid});

  Future updateUserDate(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'strength' : strength,
      'name' : name
    }); 
  }
  // getting list of bews from a snapshot
  List<Brew> _getBrewListFromSnapshot(QuerySnapshot snapshot){
    return   snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '', 
        strength: doc.data['strength'] ?? 0,
        sugras: doc.data['sugars'] ?? '0',
        );
    }).toList();
      
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_getBrewListFromSnapshot);
  }
}