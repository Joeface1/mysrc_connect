import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "About",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/aboutApp.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        "My SRC Connect",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const Divider(),
                      const Text(
                        "Version 1.0.0",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                          textAlign: TextAlign.center,
                          "SRC Connect is a mobile application that helps the PU SRC board, desiminate News and Updates to the entire populance."),
                      const Divider(),
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                          textAlign: TextAlign.center,
                          "Email: group1@mysrcconnect@gmail.com"),
                      const Text(
                          textAlign: TextAlign.center,
                          "Website: www.mysrcconnect.com"),
                      const Text(
                        textAlign: TextAlign.center,
                        "Twitter: @mysrcconnect",
                      ),
                      const Divider(),
                      const Text(
                        "Developers",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        child: const Column(
                          children: [
                            Text(
                              "Commietey Joseph - PUC/200032",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "Ansah Francisca Abban - PUC/200586",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
