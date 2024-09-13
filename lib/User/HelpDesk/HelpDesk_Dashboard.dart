import "package:flutter/material.dart";
import "package:mysrc_connect/User/HelpDesk/AskQuestions.dart";
import "package:mysrc_connect/User/HelpDesk/Sent_Complaints_Page.dart";
import "package:mysrc_connect/User/HelpDesk/Sent_Suggestion_Page.dart";
import "package:mysrc_connect/User/HelpDesk/faqs_page.dart";

class HelpDeskDashboard extends StatelessWidget {
  const HelpDeskDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Student Help Desk",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                alignment: Alignment.center,
                //color: Colors.red,
                child: const Text(
                  "What do you want to do?",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SentComplaints()));
                },
                child: Container(
                  height: 62,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 9, 73, 105),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Send Complaint",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SentSuggestions()));
                },
                child: Container(
                  height: 62,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 9, 73, 105),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Send Suggestion",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FAQPage()));
                },
                child: Container(
                  height: 62,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 9, 73, 105),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "FAQs",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AskQuestionPage()));
                },
                child: Container(
                  height: 62,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 9, 73, 105),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Ask Question",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/support.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
