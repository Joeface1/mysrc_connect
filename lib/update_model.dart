// update_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateModel with ChangeNotifier {
  String _message = '';
  String _issuedBy = '';
  String _subject = '';
  String _president = '';
  String _vicePresident = '';

  String get message => _message;
  String get issuedBy => _issuedBy;
  String get subject => _subject;
  String get president => _president;
  String get vicePresident => _vicePresident;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postUpdate(String message, String issuedBy, String subject,
      String president, String vicePresident) async {
    _message = message;
    _issuedBy = issuedBy;
    _subject = subject;
    _president = president;
    _vicePresident = vicePresident;

    await _firestore.collection('adminData').add({
      'message': message,
      'issuedBy': issuedBy,
      'subject': subject,
      'president': president,
      'vicePresident': vicePresident,
      'timestamp': FieldValue.serverTimestamp(),
    });
    notifyListeners();
  }

  Future<void> fetchUpdate() async {
    final snapshot = await _firestore
        .collection('adminData')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      _message = data['message'];
      _issuedBy = data['issuedBy'];
      _subject = data['subject'];
      _president = data['president'];
      _vicePresident = data['vicePresident'];
      notifyListeners();
    }
  }
}

class TuitionEnrollmentCountModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  Future<void> fetchCount() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('adminData').get();
      _count = snapshot.size;
      notifyListeners();
    } catch (e) {
      print("Error fetching tuition and enrollment count: $e");
    }
  }
}

class TuitionEnrollmentModel with ChangeNotifier {
  List<Map<String, dynamic>> _messages = [];
  int get unreadCount => _messages.where((msg) => !msg['read']).length;

  List<Map<String, dynamic>> get messages => _messages;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchMessages() async {
    try {
      final querySnapshot = await _firestore
          .collection('adminData')
          .orderBy('date', descending: true)
          .get();

      _messages = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'message': data['message'] ?? '',
          'issuedBy': data['issuedBy'] ?? '',
          'subject': data['subject'] ?? '',
          'president': data['president'] ?? '',
          'vicePresident': data['vicePresident'] ?? '',
          'date': data['date'] ?? Timestamp.now(),
        };
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }
}
