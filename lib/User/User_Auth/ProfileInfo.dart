import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysrc_connect/Server.dart';

class UserProfileInfoPage extends StatefulWidget {
  final Function(String) onImageUploaded;

  const UserProfileInfoPage({super.key, required this.onImageUploaded});

  @override
  _UserProfileInfoPageState createState() => _UserProfileInfoPageState();
}

class _UserProfileInfoPageState extends State<UserProfileInfoPage> {
  File? _imageFile;
  bool _isPickingImage = false;
  bool _isUploadingImage = false;

  String fullName = '';
  String studentId = '';
  String email = '';
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    UserService userService = UserService();
    try {
      fullName = await userService.getUserFullName() ?? '';
      studentId = await userService.getUserStudentId() ?? '';
      email = await userService.getUserEmail() ?? '';
      profileImageUrl = await userService.getUserProfileImageUrl();

      setState(() {});
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _pickImage() async {
    setState(() {
      _isPickingImage = true;
    });

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
      _isPickingImage = false;
    });
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_imageFile == null) return;

    setState(() {
      _isUploadingImage = true;
    });

    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'user_profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_imageFile!);
      final downloadURL = await storageRef.getDownloadURL();
      print('Uploaded Image URL: $downloadURL');
      widget.onImageUploaded(downloadURL);

      UserService userService = UserService();
      await userService.updateUserProfileImage(downloadURL);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Update successful"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error uploading image: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Image update unsuccessful. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isUploadingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        foregroundColor: const Color(0xFFFFFFFF),
        toolbarHeight: 80,
        title: const Text(
          'Personal Information',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isUploadingImage ? null : () => _uploadImage(context),
            child: _isUploadingImage
                ? const CircularProgressIndicator(color: Colors.red)
                : const Text(
                    "SAVE",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0778AC),
                        width: 4.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : profileImageUrl != null &&
                                  profileImageUrl!.isNotEmpty
                              ? NetworkImage(profileImageUrl!)
                                  as ImageProvider<Object>?
                              : null,
                    ),

                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _isPickingImage ? null : _pickImage,
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 7, 120, 172),
                        child: _isPickingImage
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfoRow("Fullname", fullName),
                  _buildUserInfoRow("Student ID", studentId),
                  _buildUserInfoRow("Email Address", email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 126, 125, 125),
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const Divider(),
      ],
    );
  }
}

