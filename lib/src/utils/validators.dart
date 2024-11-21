class Validators {
  // Validates an email using regex
  static String? validateEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null; // No error
  }

  // Validates password strength (minimum 8 characters, 1 uppercase, 1 number)
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return 'Password must contain at least 1 uppercase letter and 1 number';
    }
    return null; // No error
  }

  // Validates name input (no numbers or special characters)
  static String? validateName(String name) {
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    if (name.isEmpty) {
      return 'Name cannot be empty';
    } else if (!nameRegex.hasMatch(name)) {
      return 'Enter a valid name (letters only)';
    }
    return null;
  }

  // Validate phone number
  static String? validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r"^\d{10,12}$");
    if (phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!phoneRegex.hasMatch(phoneNumber)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // Validate Date of Birth (simple example)
  static String? validateDate(String date) {
    // Implement proper date validation
    if (date.isEmpty) {
      return 'Date of Birth cannot be empty';
    }
    // You can use DateTime.tryParse or regex for better validation
    return null;
  }

  // Validate Time of Birth (simple example)
  static String? validateTime(String time) {
    if (time.isEmpty) {
      return 'Time of Birth cannot be empty';
    }
    // Implement proper time validation
    return null;
  }

  // Validate Location
  static String? validateLocation(String location) {
    if (location.isEmpty) {
      return 'Location of Birth cannot be empty';
    }
    return null;
  }

  // Validate Blood Group
  static String? validateBloodGroup(String bloodGroup) {
    final validGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    if (bloodGroup.isEmpty) {
      return 'Blood Group cannot be empty';
    } else if (!validGroups.contains(bloodGroup.toUpperCase())) {
      return 'Enter a valid Blood Group';
    }
    return null;
  }

  // Validate Height
  static String? validateHeight(String height) {
    if (height.isEmpty) {
      return 'Height cannot be empty';
    }
    final heightValue = double.tryParse(height);
    if (heightValue == null || heightValue <= 0) {
      return 'Enter a valid height in cm';
    }
    return null;
  }

  // Validate Ethnicity
  static String? validateEthnicity(String ethnicity) {
    if (ethnicity.isEmpty) {
      return 'Ethnicity cannot be empty';
    }
    return null;
  }

  // Validate Eye Colour
  static String? validateEyeColor(String eyeColor) {
    if (eyeColor.isEmpty) {
      return 'Eye Colour cannot be empty';
    }
    return null;
  }
}
