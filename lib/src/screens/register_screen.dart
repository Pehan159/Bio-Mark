import 'package:biomark/src/screens/profile_screen.dart';
import 'package:biomark/src/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../models/volunteer.dart';
import '../services/firebase_service.dart';
import '../utils/hashing.dart';
import '../utils/validators.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _mothersMaidenNameController =
      TextEditingController();
  final TextEditingController _childhoodBestFriendsNameController =
      TextEditingController();
  final TextEditingController _childhoodPetsNameController =
      TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    _mothersMaidenNameController.dispose();
    _childhoodBestFriendsNameController.dispose();
    _childhoodPetsNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  // Initialize Firebase
  void initFirebase() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'YOUR_API_KEY',
        appId: 'YOUR_APP_ID',
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'YOUR_PROJECT_ID',
      ),
    );
  }

  // Implement the Registration Logic
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final authProvider = Provider.of<AuthsProvider>(context, listen: false);

      try {
        final user = await authProvider.register(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (user != null) {
          final hashedFullname =
              HashingUtils.hashData(_fullNameController.text.trim());
          final hashedemail =
              HashingUtils.hashData(_emailController.text.trim());
          final hashedPassword =
              HashingUtils.hashData(_passwordController.text.trim());
          final hasheddateOfBirth =
              HashingUtils.hashData(_dateOfBirthController.text.trim());
          final hashedmothersMaidenName =
              HashingUtils.hashData(_mothersMaidenNameController.text.trim());
          final hashedchildhoodBestFriendsName = HashingUtils.hashData(
              _childhoodBestFriendsNameController.text.trim());
          final hashedchildhoodPetsName =
              HashingUtils.hashData(_childhoodPetsNameController.text.trim());

          Volunteer volunteer = Volunteer(
            fullName: hashedFullname,
            email: hashedemail,
            password: hashedPassword,
            dateOfBirth: hasheddateOfBirth,
            mothersMaidenName: hashedmothersMaidenName,
            childhoodBestFriendsName: hashedchildhoodBestFriendsName,
            childhoodPetsName: hashedchildhoodPetsName,
          );

          await FirebaseService()
              .saveVolunteerData(user.uid, volunteer.toMap());
          Navigator.pushReplacementNamed(context, '/profile_setup');
        } else {
          setState(() {
            _errorMessage = 'Registration failed. Please try again.';
          });
        }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppConstants.defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Full Name
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) => Validators.validateName(value!),
                ),
                SizedBox(height: 15),

                // Email Address
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validators.validateEmail(value!),
                ),
                SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => Validators.validatePassword(value!),
                ),
                SizedBox(height: 25),

                // Date of Birth
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  obscureText: true,
                  validator: (value) => Validators.validateDate(value!),
                ),
                SizedBox(height: 50),

                // Security Questions
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Security Questions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 50),

                // Security Question 1
                TextFormField(
                  controller: _mothersMaidenNameController,
                  decoration:
                      InputDecoration(labelText: "Mother's Maiden Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please answer this security question';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Security Question 2
                TextFormField(
                  controller: _childhoodBestFriendsNameController,
                  decoration: InputDecoration(
                      labelText: "Childhood Best Friend's Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please answer this security question';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Security Question 3
                TextFormField(
                  controller: _childhoodPetsNameController,
                  decoration:
                      InputDecoration(labelText: "Childhood Pet's Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please answer this security question';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),

                // Error Message
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),

                // Register Button
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
                        onPressed: _register,
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),

                // Navigate to Login Screen
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text('Already have an account? Login here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
