import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure to import this

class Examination extends StatefulWidget {
  const Examination({super.key});

  @override
  _ExaminationState createState() => _ExaminationState();
}

class _ExaminationState extends State<Examination> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examination Timetables'),
        backgroundColor: Colors.blueGrey,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for Exams Timetable',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('timetables').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final timetables = snapshot.data!.docs.where((doc) {
            final faculty = doc['faculty'].toString().toLowerCase();
            final subject = doc['subject'].toString().toLowerCase();
            final semesterTrimester =
                doc['semesterTrimester'].toString().toLowerCase();

            return faculty.contains(_searchQuery) ||
                subject.contains(_searchQuery) ||
                semesterTrimester.contains(_searchQuery);
          }).toList();

          return ListView.builder(
            itemCount: timetables.length,
            itemBuilder: (context, index) {
              final timetable = timetables[index];
              final faculty = timetable['faculty'];
              final subject = timetable['subject'];
              final schoolType = timetable['schoolType'];
              final semesterTrimester = timetable['semesterTrimester'];
              final fileName = timetable['fileName'];
              final downloadUrl = timetable['url'];

              final displayTitle =
                  '$faculty REGULAR-PROVISIONAL EXAMS TIMETABLE-$semesterTrimester';

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(displayTitle),
                  subtitle: Text('Subject: $subject'),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () async {
                      if (await canLaunch(downloadUrl)) {
                        await launch(downloadUrl);
                      } else {
                        throw 'Could not launch $downloadUrl';
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
