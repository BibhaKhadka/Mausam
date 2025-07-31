import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveCity(String city) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).collection('cities').add({
      'name': city,
      'savedAt': Timestamp.now(),
    });
  }

  Stream<List<String>> getSavedCities() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cities')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc['name'] as String).toList());
  }
}
