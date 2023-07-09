import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDataBaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<List<String?>> getWords() async {
    try {
      final wordsSnapshot = await _databaseReference.limitToFirst(300).get();

      var map = wordsSnapshot.value as Map<Object?, Object?>;

      List<String?> keys = [];
      for (var element in map.keys) {
        keys.add(
          element.toString(),
        );
      }

      return keys;
    } catch (e) {
      throw Exception(e.toString());
    }

  }
}
