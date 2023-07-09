import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDataBaseService {

 final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

 Future<List<String>>getWords() async {
    try{
      final wordsSnapshot = await _databaseReference.limitToFirst(300).get();

      List<String> list = [];

      var map = wordsSnapshot.value as Map<Object?, Object?>;

      for (var element in map.keys) {
         list.add(element.toString());
      }

      return list  ;
    } catch (e){
      debugPrint(" Erro ao acessar RealTime data base ${e.toString()}");

    }
    return [];
  }

}