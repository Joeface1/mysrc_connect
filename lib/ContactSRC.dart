import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSRCPage extends StatelessWidget {
  const ContactSRCPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Contact the SRC Board',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ContactCard(
            name: 'SRC President',
            phoneNumber: '0542881261',
          ),
          ContactCard(
            name: 'Vice President',
            phoneNumber: '234-567-8901',
          ),
          ContactCard(
            name: 'General Secretary',
            phoneNumber: '0555025392',
          ),
          ContactCard(
            name: 'Financial Controller',
            phoneNumber: '0599698619',
          ),
          ContactCard(
            name: "Women's Commissioner",
            phoneNumber: '',
          ),
          ContactCard(
            name: "Speaker of Parliament",
            phoneNumber: '',
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ContactCard({
    super.key,
    required this.name,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Phone: $phoneNumber',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        onTap: () {
          // Implement action to call or message the board member
          // You can use launch_url or other packages for this
        },
        trailing: IconButton(
          icon: const Icon(Icons.phone),
          onPressed: () {
            _makePhoneCall(phoneNumber);
          },
        ),
      ),
    );
  }
}

void _makePhoneCall(String phoneNumber) async {
  final String formattedPhoneNumber = 'tel:$phoneNumber';
  try {
    if (await canLaunch(formattedPhoneNumber)) {
      await launch(formattedPhoneNumber);
    } else {
      throw 'Could not launch $formattedPhoneNumber';
    }
  } catch (e) {
    print('Error launching phone call: $e');
    // Handle error gracefully, such as displaying an error message to the user
  }
}
