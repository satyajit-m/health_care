import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/core/models/UserProf.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  Future<void> uploadAgent(
      List<Map<String, String>> data, String col, String doc) async {
    DocumentReference documentReference =
        _firestore.collection(col).document(doc);
    return _firestore.runTransaction((transaction) async {
      await transaction.set(documentReference, {
        'personal': data[0],
        'address': data[1],
        'identification': data[2],
        'verified': false,
      }).catchError((e) {
        print(e);
      }).whenComplete(() {});
    }).catchError((e) {
      print(e);
      return false;
    });
  }

}
