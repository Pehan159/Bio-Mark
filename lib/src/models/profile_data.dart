class ProfileData {
  String dateOfBirth;
  String timeOfBirth;
  String locationOfBirth;
  String bloodGroup;
  String sex;
  double height;
  String ethnicity;
  String eyeColor;

  ProfileData({
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.locationOfBirth,
    required this.bloodGroup,
    required this.sex,
    required this.height,
    required this.ethnicity,
    required this.eyeColor,
  });

  // Method to convert profile data to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'dateOfBirth': dateOfBirth,
      'timeOfBirth': timeOfBirth,
      'locationOfBirth': locationOfBirth,
      'bloodGroup': bloodGroup,
      'sex': sex,
      'height': height,
      'ethnicity': ethnicity,
      'eyeColor': eyeColor,
    };
  }

  // Method to create ProfileData object from a map
  factory ProfileData.fromMap(Map<String, dynamic> map) {
    return ProfileData(
      dateOfBirth: map['dateOfBirth'],
      timeOfBirth: map['timeOfBirth'],
      locationOfBirth: map['locationOfBirth'],
      bloodGroup: map['bloodGroup'],
      sex: map['sex'],
      height: map['height'],
      ethnicity: map['ethnicity'],
      eyeColor: map['eyeColor'],
    );
  }
}
