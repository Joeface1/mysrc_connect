import 'package:flutter/material.dart';
import 'package:mysrc_connect/User/HelpDesk/SuggestionForm.dart';

class SentSuggestions extends StatelessWidget {
  const SentSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Suggestion Sent",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Stack(
        children: [
          const SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: 70), // Add padding to avoid overlap
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ComplaintCard(
                    date: "21-04-2024",
                    time: "09:20am",
                    title: "Facilities Suggestion",
                    description: "Our laboratory is not in a good shape...",
                  ),
                  SizedBox(height: 10),
                  ComplaintCard(
                    date: "21-04-2024",
                    time: "09:20am",
                    title: "Facilities Suggestion",
                    description: "Our laboratory is not in a good shape...",
                  ),
                  SizedBox(height: 10),
                  ComplaintCard(
                    date: "21-04-2024",
                    time: "09:20am",
                    title: "Facilities Suggestion",
                    description: "Our laboratory is not in a good shape...",
                  ),
                  SizedBox(height: 10),
                  ComplaintCard(
                    date: "21-04-2024",
                    time: "09:20am",
                    title: "Facilities Suggestion",
                    description: "Our laboratory is not in a good shape...",
                  ),
                  SizedBox(height: 10),
                  ComplaintCard(
                    date: "21-04-2024",
                    time: "09:20am",
                    title: "Facilities Suggestion",
                    description: "Our laboratory is not in a good shape...",
                  ),
                  SizedBox(height: 10),
                  ComplaintCard(
                    date: "21-04-2024",
                    time: "09:20am",
                    title: "Facilities Suggestion",
                    description: "Our laboratory is not in a good shape...",
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              //color: Colors.white,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuggestionForm()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27B3CC),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 3,
                  //style: ElevatedButton,
                ),
                child: const Text(
                  "Send Suggestion",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
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

  const ComplaintCard({
    super.key,
    required this.date,
    required this.time,
    required this.title,
    required this.description,
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
              const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
