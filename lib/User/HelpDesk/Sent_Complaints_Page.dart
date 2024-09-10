import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mysrc_connect/User/HelpDesk/ComplaintForm.dart';

class SentComplaints extends StatelessWidget {
  const SentComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Sent Complaints",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final complaints = snapshot.data!.docs;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 70),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: complaints.map((complaint) {
                      final data = complaint.data() as Map<String, dynamic>;
                      final timestamp = data['timestamp'] as Timestamp?;
                      final date = timestamp != null
                          ? timestamp
                              .toDate()
                              .toLocal()
                              .toString()
                              .split(' ')[0]
                          : 'Unknown date';
                      final time = timestamp != null
                          ? timestamp
                              .toDate()
                              .toLocal()
                              .toString()
                              .split(' ')[1]
                              .split('.')[0]
                          : 'Unknown time';
                      final title = data['subject'] ?? 'No subject';
                      final description =
                          data['complaints'] ?? 'No description';
                      final complaintId = complaint.id;

                      return Column(
                        children: [
                          ComplaintCard(
                            date: date,
                            time: time,
                            title: title,
                            description: description,
                            onDelete: () async {
                              await FirebaseFirestore.instance
                                  .collection('complaints')
                                  .doc(complaintId)
                                  .delete();
                            },
                            onEdit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComplaintsForm(
                                    complaintId: complaintId,
                                    initialFaculty: data['faulty'],
                                    initialSubject: title,
                                    initialComplaints: description,
                                    initialIsAnonymous:
                                        data['isAnonymous'] ?? false,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ComplaintsForm(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27B3CC),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Send Complaint",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget to display individual complaint cards
class ComplaintCard extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final String description;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ComplaintCard({
    super.key,
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color(0x5FB2DAFA),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
