import 'package:biomark/src/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../models/profile_data.dart';
import '../services/firebase_service.dart';
import '../utils/validators.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for profile fields
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _timeOfBirthController = TextEditingController();
  final TextEditingController _locationOfBirthController =
      TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _eyeColorController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        // Create ProfileData object
        ProfileData profile = ProfileData(
          dateOfBirth: _dobController.text.trim(),
          timeOfBirth: _timeOfBirthController.text.trim(),
          locationOfBirth: _locationOfBirthController.text.trim(),
          bloodGroup: _bloodGroupController.text.trim(),
          sex: _sexController.text.trim(),
          height: double.parse(_heightController.text.trim()),
          ethnicity: _ethnicityController.text.trim(),
          eyeColor: _eyeColorController.text.trim(),
        );

        // Encrypt profile data if storing locally
        // String encryptedDOB = EncryptionUtils.encryptData(profile.dateOfBirth);
        // ... similarly encrypt other fields as needed

        // Save profile data to Firebase
        await FirebaseService().saveProfileData(profile.toMap());

        // Optionally, save encrypted profile data to SQLite
        // await SQLiteService().saveProfileData(encryptedProfileData);

        // Navigate to Profile Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _dobController.dispose();
    _timeOfBirthController.dispose();
    _locationOfBirthController.dispose();
    _bloodGroupController.dispose();
    _sexController.dispose();
    _heightController.dispose();
    _ethnicityController.dispose();
    _eyeColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Setup',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Date of Birth
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                validator: (value) => Validators.validateDate(value!),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),

              // Time of Birth
              TextFormField(
                controller: _timeOfBirthController,
                decoration: InputDecoration(labelText: 'Time of Birth'),
                validator: (value) => Validators.validateTime(value!),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),

              // Location of Birth
              TextFormField(
                controller: _locationOfBirthController,
                decoration: InputDecoration(labelText: 'Location of Birth'),
                validator: (value) => Validators.validateLocation(value!),
              ),
              SizedBox(height: 10),

              // Blood Group
              TextFormField(
                controller: _bloodGroupController,
                decoration: InputDecoration(labelText: 'Blood Group'),
                validator: (value) => Validators.validateBloodGroup(value!),
              ),
              SizedBox(height: 10),

              // Sex
              DropdownButtonFormField<String>(
                value: null,
                decoration: InputDecoration(labelText: 'Sex'),
                items: ['Male', 'Female', 'Other']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  _sexController.text = value!;
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select your sex'
                    : null,
              ),
              SizedBox(height: 10),

              // Height
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                validator: (value) => Validators.validateHeight(value!),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              // Ethnicity
              TextFormField(
                controller: _ethnicityController,
                decoration: InputDecoration(labelText: 'Ethnicity'),
                validator: (value) => Validators.validateEthnicity(value!),
              ),
              SizedBox(height: 10),

              // Eye Colour
              TextFormField(
                controller: _eyeColorController,
                decoration: InputDecoration(labelText: 'Eye Colour'),
                validator: (value) => Validators.validateEyeColor(value!),
              ),
              SizedBox(height: 20),

              // Error Message
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),

              // Submit Button
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
                      onPressed: _submitProfile,
                      child: Text(
                        'Save Profile',
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
