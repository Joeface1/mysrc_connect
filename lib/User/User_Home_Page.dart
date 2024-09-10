import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mysrc_connect/Server.dart';
import 'package:mysrc_connect/User/AboutSRC/about_SRC_Page.dart';
import 'package:mysrc_connect/User/Evaluation/Evaluation_Page.dart';
import 'package:mysrc_connect/User/HelpDesk/HelpDesk_Dashboard.dart';
import 'package:mysrc_connect/User/NewsFeed/NewsFeed.dart';
import 'package:mysrc_connect/User/myappbar.dart';
import 'package:mysrc_connect/how_to_login.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  Future<void> _logOut(BuildContext context) async {
    await Server().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HowToLogin(), // User will be logged out
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          // Carousel Slider
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
              ),
              items: [
                _buildCarouselItem('images/graduateHome.jpg', 'Newsfeed'),
                _buildCarouselItem('images/graduateHome.jpg', 'Help Desk'),
                _buildCarouselItem('images/graduateHome.jpg', 'Evaluation'),
                _buildCarouselItem('images/graduateHome.jpg', 'About SRC'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildCard(
                  title: "NEWSFEED",
                  subtitle: "Get all SRC latest updates here",
                  color1: const Color(0xFFFFB907),
                  color2: const Color.fromARGB(255, 250, 192, 45),
                  image: Image.asset("images/newimage.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewsFeed()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildCard(
                  title: "HELP DESK",
                  subtitle: "Send feedback or challenges",
                  color1: const Color(0xFF09BEA8),
                  color2: const Color(0xFF30DAC6),
                  image: Image.asset("images/helpDesk.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpDeskDashboard()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildCard(
                  title: "EVALUATION",
                  subtitle: "Click here to evaluate the SRC",
                  color1: const Color(0xFF1C3DE5),
                  color2: const Color(0xFF456BCC),
                  image: Image.asset("images/evaluate.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Evaluation()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildCard(
                  title: "ABOUT SRC",
                  subtitle: "Know more about PU SRC",
                  color1: const Color(0xFF9208FF),
                  color2: const Color(0xFFB85DFF),
                  image: Image.asset("images/info.png"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutSrc()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Color color1,
    required Color color2,
    required VoidCallback onTap,
    required Image image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 50,
                child:
                    //Image.asset("assets/icon.png"),
                    image,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
