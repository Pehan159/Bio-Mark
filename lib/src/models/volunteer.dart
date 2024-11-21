class Volunteer {
  String fullName;
  String email;
  String password;
  String dateOfBirth;
  String mothersMaidenName;
  String childhoodBestFriendsName;
  String childhoodPetsName;

  Volunteer({
    required this.fullName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.mothersMaidenName,
    required this.childhoodBestFriendsName,
    required this.childhoodPetsName,
  });

  // Method to convert volunteer data to a map for storage (in Firebase or local DB)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password, // Should be hashed for security purposes
      'dateOfBirth': dateOfBirth,
      'mothersMaidenName': mothersMaidenName, // Should be hashed for security
      'childhoodBestFriendsName': childhoodBestFriendsName,
      'childhoodPetsName': childhoodPetsName, // Should be hashed for security
    };
  }

  // Method to create a Volunteer object from a map (useful for data retrieval)
  factory Volunteer.fromMap(Map<String, dynamic> map) {
    return Volunteer(
      fullName: map['fullName'],
      email: map['email'],
      password: map['password'],
      dateOfBirth: map['dateOfBirth'],
      mothersMaidenName: map['mothersMaidenName'],
      childhoodBestFriendsName: map['childhoodBestFriendsName'],
      childhoodPetsName: map['childhoodPetsName'],
    );
  }
}
