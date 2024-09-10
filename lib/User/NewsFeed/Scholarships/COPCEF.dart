import "package:flutter/material.dart";

class CopcefScholarship extends StatelessWidget {
  const CopcefScholarship({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "COPCEF Scholarship",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
