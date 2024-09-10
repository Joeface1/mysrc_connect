import 'package:flutter/material.dart';

class StudentLoanPage extends StatelessWidget {
  const StudentLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Student Loan Trust Fund",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(63)),
              child: Image.asset(
                'images/graduate.jpg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Loan Application Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            ),
            _buildExpansionTile(
              'INTRODUCTION',
              [
                'Drink at least 8 cups of water a day.',
              ],
            ),
            _buildExpansionTile(
              'BENEFITS OF STUDENT LOAN',
              [
                'Include water-rich foods in your diet.',
              ],
            ),
            _buildExpansionTile(
              'ELIGIBILITY',
              [
                'Drink a glass of water before bed.',
              ],
            ),
            _buildExpansionTile(
              'APPLICATION REQUIREMENTS',
              [
                'Stay hydrated before, during, and after exercise.',
              ],
            ),
            _buildExpansionTile(
              'HOW TO APPLY FOR STUDENTS LOAN',
              [
                'Stay hydrated before, during, and after exercise.',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, List<String> tips) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: tips.map((tip) {
        return ListTile(
          title: Text(
            tip,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
            ),
          ),
          tileColor: Colors.grey[100],
        );
      }).toList(),
    );
  }
}
