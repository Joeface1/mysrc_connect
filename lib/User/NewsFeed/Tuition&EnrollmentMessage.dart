import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessageDetailPage extends StatelessWidget {
  final String? subject;
  final String? message;
  final Timestamp? timestamp;

  const MessageDetailPage({
    super.key,
    required this.subject,
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          subject ?? 'Message Detail',
          style: const TextStyle(),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (timestamp != null)
              Text(
                'Date: ${DateFormat('dd-MM-yyyy – kk:mm').format(timestamp!.toDate())}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            const SizedBox(height: 16),
            const Text(
              "Issued By",
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const Text(
              "The SRC President",
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const Text(
              "The SRC Vice President",
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text(
              subject ?? 'No subject',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message ?? 'No message content',
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
