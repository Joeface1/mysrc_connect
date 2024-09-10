import 'package:flutter/material.dart';

class ComplaintsReceived extends StatelessWidget {
  const ComplaintsReceived({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A5A5A),
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Complaints Received",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Complaints will be displayed here.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
