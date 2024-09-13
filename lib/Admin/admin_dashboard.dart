import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysrc_connect/Admin/Complaints_Received.dart';
import 'package:mysrc_connect/Admin/Evaluation_Page.dart';
import 'package:mysrc_connect/Admin/Event_Post_Page.dart';
import 'package:mysrc_connect/Admin/Questions_Received.dart';
import 'package:mysrc_connect/Admin/Suggestions_Received_Page.dart';
import 'package:mysrc_connect/Admin/TimeTable_Upload.dart';
import 'package:mysrc_connect/Admin/Tuition&EnrollmentUpload.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return buildDashboardTile(
                      context,
                      "0",
                      "Messages Posted",
                      const Color(0xFF1B85A7),
                      Icons.message,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TuitionEnrollmentAdmin()),
                        );
                      },
                    );
                  }
                  final messageCount = snapshot.data!.docs.length;
                  return buildDashboardTile(
                    context,
                    messageCount.toString(),
                    "Tuition & Enrollment",
                    const Color(0xFF1B85A7),
                    Icons.message,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TuitionEnrollmentAdmin()),
                      );
                    },
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('timetables')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return buildDashboardTile(
                      context,
                      "0",
                      "Examination Timetable",
                      const Color.fromARGB(255, 0, 95, 24),
                      Icons.add_circle,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TimeTablePost()),
                        );
                      },
                    );
                  }
                  final eventCount = snapshot.data!.docs.length;
                  return buildDashboardTile(
                    context,
                    eventCount.toString(),
                    "Examination Timetable",
                    const Color.fromARGB(255, 2, 84, 14),
                    Icons.add_circle,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TimeTablePost()),
                      );
                    },
                  );
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return buildDashboardTile(
                      context,
                      "0",
                      "Event Post",
                      const Color(0xFFFFB907),
                      Icons.add_circle,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EventsUpdatePage()),
                        );
                      },
                    );
                  }
                  final eventCount = snapshot.data!.docs.length;
                  return buildDashboardTile(
                    context,
                    eventCount.toString(),
                    "Event Post",
                    const Color(0xFFFFB907),
                    Icons.add_circle,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventsUpdatePage()),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 3),
              const SizedBox(height: 3),
              const Text(
                "Student Help Desk",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 24, 1, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  fontFamily: 'Poppins',
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    buildHelpDeskTile(
                      context,
                      "Complaints",
                      const Color.fromARGB(255, 212, 241, 255),
                      const ComplaintsReceived(),
                    ),
                    const SizedBox(height: 10),
                    buildHelpDeskTile(
                      context,
                      "Suggestions",
                      const Color.fromARGB(255, 212, 241, 255),
                      const SuggestionsReceived(),
                    ),
                    const SizedBox(height: 10),
                    buildHelpDeskTile(
                      context,
                      "Questions",
                      const Color.fromARGB(255, 212, 241, 255),
                      const QuestionsReceived(),
                    ),
                    const SizedBox(height: 10),
                    buildHelpDeskTile(
                      context,
                      "Evaluations",
                      const Color(0xFFFFB907),
                      const SRCEvaluation(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDashboardTile(
    BuildContext context,
    String count,
    String title,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  count,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHelpDeskTile(
    BuildContext context,
    String title,
    Color color,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
