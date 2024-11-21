import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/firebase_service.dart';

class UnsubscribeScreen extends StatefulWidget {
  @override
  _UnsubscribeScreenState createState() => _UnsubscribeScreenState();
}

class _UnsubscribeScreenState extends State<UnsubscribeScreen> {
  bool _isLoading = false;

  Future<void> _unsubscribe() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Confirm the user's decision to unsubscribe
      bool confirmed = await _showUnsubscribeDialog();

      if (!confirmed) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Remove user's profile data from Firebase
      await FirebaseService().deleteUserProfile();

      //Log out the user from Firebase Authentication
      await AuthService().logout();

      // Show success message and navigate to home screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You have been successfully unsubscribed.')),
      );

      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error: Could not unsubscribe. Please try again.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _showUnsubscribeDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Unsubscribe from Biomark'),
              content: const Text(
                  'Are you sure you want to unsubscribe? This will delete all your data and cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/profile'),
        ),
        title: Text(
          'Unsubscribe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'By unsubscribing, your profile data will be permanently deleted from the Biomark program.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
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
                    onPressed: _unsubscribe,
                    child: Text(
                      'Unsubscribe',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
