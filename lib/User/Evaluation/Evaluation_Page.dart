import "package:flutter/material.dart";

class Evaluation extends StatelessWidget {
  const Evaluation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        centerTitle: true,
        title: const Text(
          "Evaluation",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
