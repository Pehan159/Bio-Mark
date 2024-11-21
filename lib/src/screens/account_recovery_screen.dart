import 'package:biomark/src/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/account_recovery_service.dart';

class AccountRecoveryScreen extends StatefulWidget {
  @override
  _AccountRecoveryScreenState createState() => _AccountRecoveryScreenState();
}

class _AccountRecoveryScreenState extends State<AccountRecoveryScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController childhoodPetsName = TextEditingController();
  final TextEditingController childhoodBestFriendsName =
      TextEditingController();

  final AccountRecoveryService _accountRecoveryService =
      AccountRecoveryService();

  bool _isLoading = false;

  Future<void> _recoverAccount() async {
    setState(() {
      _isLoading = true;
    });

    print("Attempting recovery with:");
    print("Full Name: ${_fullNameController.text}");
    print("DOB: ${_dobController.text}");
    print("Childhood Pet's Name: ${childhoodPetsName.text}");
    print("Best Friend's Name: ${childhoodBestFriendsName.text}");

    bool verified = await _accountRecoveryService.verifyAccount(
      fullName: _fullNameController.text.trim(),
      dob: _dobController.text.trim(),
      childhoodPetsName: childhoodPetsName.text.trim(),
      childhoodBestFriendsName: childhoodBestFriendsName.text.trim(),
    );

    if (verified) {
      Navigator.pushNamed(context, '/reset_password');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed. Please try again.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
        ),
        title: Text(
          'Account Recovery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: childhoodPetsName,
                decoration:
                    InputDecoration(labelText: 'Your Childhood Pet\'s Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: childhoodBestFriendsName,
                decoration:
                    InputDecoration(labelText: 'Your Best Friend\'s Name'),
              ),
              SizedBox(height: 100),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 60),
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _recoverAccount,
                      child: Text(
                        'Recover Account',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
