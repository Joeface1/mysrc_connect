import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Handles all server-side operations related to authentication and user management
class Server {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Regular expression to validate the email format
  final RegExp emailRegExp = RegExp(r'^pu.*@pentvars\.edu\.gh$');

  // Register a new user
  Future<String> register(
      String fullName, String email, String studentId, String password) async {
    String profileImageUrl = "";
    if (!emailRegExp.hasMatch(email)) {
      return 'Please this email is not a student email.';
    }
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set(
          {
            'fullName': fullName,
            'email': email,
            'studentId': studentId,
            'profileImageUrl': profileImageUrl,
          },
        );
        await _sendVerificationEmail(user);
        return 'Successfully registered! A verification email has been sent.';
      } else {
        return 'Registration failed. User is null.';
      }
    } catch (e) {
      return 'Registration failed: $e';
    }
  }

  // Sign in with email and password
  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          return 'Successfully signed in!';
        } else {
          await _auth.signOut();
          return 'Please verify your email before signing in.';
        }
      } else {
        return 'Log in failed. User is null.';
      }
    } catch (e) {
      return 'Log in failed: $e';
    }
  }

  // Send email verification
  Future<void> _sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
  }

  // Resend email verification
  Future<void> resendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await _sendVerificationEmail(user);
    }
  }

  // Check email verification status
  Future<bool> checkEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      return user.emailVerified;
    }
    return false;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

// Service class for user-related operations
class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the full name of the currently signed-in user
  Future<String?> getUserFullName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc['fullName'];
      }
    }
    return null;
  }

  // Fetch the email of the currently signed-in user
  Future<String?> getUserEmail() async {
    User? user = _auth.currentUser;
    return user?.email;
  }

  // Fetch the student ID of the currently signed-in user
  Future<String?> getUserStudentId() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc['studentId'];
      }
    }
    return null;
  }

  // Fetch the profile image URL of the currently signed-in user
  Future<String?> getUserProfileImageUrl() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc['profileImageUrl'];
      }
    }
    return null;
  }

  // Update the profile image URL for the currently signed-in user
  Future<void> updateUserProfileImage(String imageUrl) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'profileImageUrl': imageUrl,
      });
    }
  }
}

class AdminUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getUserFullName() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        return userDoc['userName'];
      }
    } catch (e) {
      print('Error fetching user full name: $e');
    }
    return null;
  }

  Future<String?> getUserEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        return userDoc['email'];
      }
    } catch (e) {
      print('Error fetching user email: $e');
    }
    return null;
  }

  Future<String?> getUserProfileImageUrl() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        return userDoc['profileImageUrl'];
      }
    } catch (e) {
      print('Error fetching user profile image URL: $e');
    }
    return null;
  }

  Future<void> updateUserProfileImage(String imageUrl) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': imageUrl,
        });
      }
    } catch (e) {
      print('Error updating user profile image: $e');
    }
  }
}
