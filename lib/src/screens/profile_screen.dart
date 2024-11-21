import 'package:biomark/src/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  Map<String, dynamic>? _profileData;
  Map<String, dynamic>? _volunteerData;
  final FirebaseService _firebaseService =
      FirebaseService(); // Instance of the service

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _fetchProfileData();
    _fetchVolunteerData();
  }

  Future<void> _fetchProfileData() async {
    if (_currentUser != null) {
      Map<String, dynamic>? data =
          await _firebaseService.fetchProfileData(_currentUser!.uid);
      setState(() {
        _profileData = data;
      });
    }
  }

  Future<void> _fetchVolunteerData() async {
    if (_currentUser != null) {
      Map<String, dynamic>? data =
          await _firebaseService.getVolunteerData(_currentUser!.uid);
      setState(() {
        _volunteerData = data;
      });
    }
  }

  Future<void> _signOut() async {
    await AuthService().logout();
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            //onPressed: _signOut, // Sign-out function
            onPressed: _signOut, // Sign-out function
          ),
        ],
      ),
      body: _profileData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/src/images/user.jpg'),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Name: ${_volunteerData?['fullName'] ?? 'No Name'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${_currentUser?.email ?? 'No Email'}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Text(
                    'Date of Birth: ${_profileData?['dateOfBirth'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Time of Birth: ${_profileData?['timeOfBirth'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Location of Birth: ${_profileData?['locationOfBirth'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Blood Group: ${_profileData?['bloodGroup'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sex: ${_profileData?['sex'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Height: ${_profileData?['height'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ethnicity: ${_profileData?['ethnicity'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Eye Colour: ${_profileData?['eyeColor'] ?? 'Not set'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 60),
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/unsubscribe');
                            },
                            child: Text(
                              'Unsubscribe',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
