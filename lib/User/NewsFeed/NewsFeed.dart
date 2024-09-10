import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mysrc_connect/User/NewsFeed/Event_Page.dart';
import 'package:mysrc_connect/User/NewsFeed/Examination_Page.dart';
import 'package:mysrc_connect/User/NewsFeed/Scholarships/Scholarship.dart';
import 'package:mysrc_connect/User/NewsFeed/Tuition&Enrollment.dart';
import 'package:provider/provider.dart';
import 'package:mysrc_connect/update_model.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "NewsFeed",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 5),
              ),
              items: [
                "images/pucampus.jfif",
                "images/puentrance.jfif",
                "images/graduate.jpg",
                "images/puGraduation.jfif",
                "images/puGraduation1.jpg",
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(i),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Welcome Message
            const Text(
              "Welcome to the News Feed! Browse through the latest updates below.",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Consumer<TuitionEnrollmentModel>(
              builder: (context, model, child) {
                return buildNewsFeedItem(
                  context,
                  title: "Tuition & Enrollment",
                  // notificationCount: model.unreadCount,
                  // showNotificationCount: true,
                  notificationCount: 0,
                  showNotificationCount: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessagesListPage(),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            buildNewsFeedItem(
              context,
              title: "Examination Timetable",
              notificationCount: 0,
              showNotificationCount: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Examination(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            buildNewsFeedItem(
              context,
              title: "Scholarships",
              notificationCount: 0,
              showNotificationCount: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Scholarship(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            buildNewsFeedItem(
              context,
              title: "Events",
              notificationCount: 0,
              showNotificationCount: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Events(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsFeedItem(
    BuildContext context, {
    required String title,
    required int notificationCount,
    required bool showNotificationCount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 167, 228, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showNotificationCount)
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Text(
                  "$notificationCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
