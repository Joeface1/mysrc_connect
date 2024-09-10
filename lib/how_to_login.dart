import 'package:flutter/material.dart';
import 'package:mysrc_connect/Admin/Admin_Auth/admin_login_page.dart';
import 'package:mysrc_connect/User/User_Auth/user_login.dart';

class HowToLogin extends StatelessWidget {
  const HowToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: screenHeight * 1,
          width: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/background_howto.jpg',
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 50,
                  width: screenWidth * 1,
                  child: Container(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Choose your account type",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserLogIn()));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // Text color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100), // Button border radius
                            ),
                            elevation: 3, // Button elevation
                          ),
                          child: const Text(
                            "Student",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AdminLogin()));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF012064), // Text color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100), // Button border radius
                            ),
                            elevation: 3, // Button elevation
                          ),
                          child: const Text(
                            "Administrator",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
