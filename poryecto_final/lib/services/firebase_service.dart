import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }
}
