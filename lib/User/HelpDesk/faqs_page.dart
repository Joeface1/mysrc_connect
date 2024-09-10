import 'package:flutter/material.dart';


class FAQPage extends StatelessWidget {
  final List<FAQ> faqs = [
    FAQ(
        question: 'How do I reset my password?',
        answer:
            'To reset your password, go to the settings page and click on "Reset Password".'),
    FAQ(
        question: 'How can I contact support?',
        answer: 'You can contact support via email at support@example.com.'),
    FAQ(
        question: 'Where can I find the user manual?',
        answer:
            'The user manual is available in the "Help" section of the app.'),
    FAQ(
        question: 'Where can I find the user manual?',
        answer:
            'The user manual is available in the "Help" section of the app.'),
    FAQ(
        question: 'Where can I find the user manual?',
        answer:
            'The user manual is available in the "Help" section of the app.'),
    FAQ(
        question: 'Where can I find the user manual?',
        answer:
            'The user manual is available in the "Help" section of the app.'),
    FAQ(
        question: 'Where can I find the user manual?',
        answer:
            'The user manual is available in the "Help" section of the app.'),
  ];

  FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('FAQs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    leading: const Icon(
                      Icons.question_answer,
                      color: Color.fromARGB(255, 13, 95, 161),
                    ),
                    title: Text(
                      faqs[index].question,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 4, 40, 104),
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Text(
                          faqs[index].answer,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const AskQuestionPage()),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFF27B3CC),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(50),
          //     ),
          //     padding: const EdgeInsets.symmetric(
          //         horizontal: 16, vertical: 10), // Button padding
          //   ),
          //   child: const Text(
          //     'Ask Question',
          //     style: TextStyle(
          //       fontFamily: 'Poppins',
          //       color: Colors.white,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}
