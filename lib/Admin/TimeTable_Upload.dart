import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TimeTablePost extends StatefulWidget {
  const TimeTablePost({super.key});

  @override
  _TimeTablePostState createState() => _TimeTablePostState();
}

class _TimeTablePostState extends State<TimeTablePost> {
  File? _selectedFile;
  String? _fileName;
  String? _selectedFaculty;
  String? _selectedSchoolType;
  String? _selectedSemesterTrimester;
  String? _academicYear;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  final List<String> _faculties = ['FESAC', 'FBA', 'FEHAS', 'FLAW'];

  // Map to store the options for regular and weekend school types
  final Map<String, List<String>> _schoolTypes = {
    'Regular School': ['1st Semester', '2nd Semester'],
    'Weekend School': ['1st Trimester', '2nd Trimester', '3rd Trimester'],
  };

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    } else {
      print('No file selected.');
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null || _fileName == null || _academicYear == null)
      return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('timetables/$_fileName');
      final uploadTask = storageRef.putFile(_selectedFile!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('timetables').add({
        'fileName': _fileName,
        'url': downloadUrl,
        'uploadTime': FieldValue.serverTimestamp(),
        'faculty': _selectedFaculty,
        'schoolType': _selectedSchoolType,
        'semesterTrimester': _selectedSemesterTrimester,
        'subject': _academicYear,
      });

      _showUploadSuccessDialog();
    } catch (e) {
      print('File upload failed: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showUploadSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("File uploaded successfully."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A5A5A),
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Examination Timetable",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Faculty",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: _selectedFaculty,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFaculty = newValue;
                  });
                },
                items: _faculties.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Academic Year",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    _academicYear = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select School Type",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: _selectedSchoolType, // Bind the selected value
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSchoolType = newValue;
                    _selectedSemesterTrimester =
                        null; // Reset semester/trimester on school type change
                  });
                },
                items: _schoolTypes.keys
                    .map<DropdownMenuItem<String>>((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              if (_selectedSchoolType != null)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Semester/Trimester",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: _selectedSemesterTrimester,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSemesterTrimester = newValue;
                    });
                  },
                  items: _schoolTypes[_selectedSchoolType]!
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickFile,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Pick File"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadFile,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Upload File"),
              ),
              const SizedBox(height: 20),
              if (_isUploading)
                Column(
                  children: [
                    const Text("Uploading..."),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: _uploadProgress),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
