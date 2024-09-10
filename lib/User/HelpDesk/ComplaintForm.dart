import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComplaintsForm extends StatefulWidget {
  final String? complaintId;
  final String? initialFaculty;
  final String? initialSubject;
  final String? initialComplaints;
  final bool? initialIsAnonymous;

  const ComplaintsForm({
    super.key,
    this.complaintId,
    this.initialFaculty,
    this.initialSubject,
    this.initialComplaints,
    this.initialIsAnonymous,
  });

  @override
  _ComplaintsFormState createState() => _ComplaintsFormState();
}

class _ComplaintsFormState extends State<ComplaintsForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isAnonymous = false;
  late TextEditingController _facultyController;
  late TextEditingController _subjectController;
  late TextEditingController _complaintsController;

  @override
  void initState() {
    super.initState();
    _facultyController = TextEditingController(text: widget.initialFaculty);
    _subjectController = TextEditingController(text: widget.initialSubject);
    _complaintsController =
        TextEditingController(text: widget.initialComplaints);
    _isAnonymous = widget.initialIsAnonymous ?? false;
  }

  Future<void> _submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      try {
        final complaintData = {
          'faculty': _facultyController.text,
          'subject': _subjectController.text,
          'complaints': _complaintsController.text,
          'isAnonymous': _isAnonymous,
          'timestamp': FieldValue.serverTimestamp(),
        };

        if (widget.complaintId != null) {
          await FirebaseFirestore.instance
              .collection('complaints')
              .doc(widget.complaintId)
              .update(complaintData);
        } else {
          await FirebaseFirestore.instance
              .collection('complaints')
              .add(complaintData);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit complaint: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "Complaint Form",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  "Fill out the form below to submit your",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _facultyController,
                  decoration: const InputDecoration(
                    labelText: 'Faculty',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a faulty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _complaintsController,
                  decoration: const InputDecoration(
                    labelText: 'Type your complaints here...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your complaints';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _isAnonymous,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAnonymous = value!;
                        });
                      },
                    ),
                    const Text('Anonymous submission'),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3BA7FF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 3,
                    ),
                    onPressed: _submitComplaint,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
