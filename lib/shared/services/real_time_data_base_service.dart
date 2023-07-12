import 'package:firebase_database/firebase_database.dart';

class RealTimeDataBaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

   get getWordsQuery => _databaseReference;

}
