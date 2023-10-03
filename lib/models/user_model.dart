/// Class that represents the fields that a user has
class UserModel {
  /// Creates a [UserModel] instance.
  ///
  /// The [email] and [fullName] parameters are required, while [age] and
  /// [technician] are optional.
  UserModel({
    required this.email,
    // required this.password,
    required this.fullName,
    required this.yearOfBirth,
    this.technician = false,
  });

  /// The email address of the user.
  final String email;

  /// The full name of the user.
  final String fullName;

  /// The user's year of birth.
  final int yearOfBirth;

  /// Indicates whether the user is a technician or not.
  ///
  /// Default is `false`.
  final bool? technician;

  /// Converts the [UserModel] instance to a JSON format.
  Map<String, dynamic> toJson() => {
        'email': email.toLowerCase(),
        // 'password': password,
        'fullName': fullName,
        'yearOfBirth': yearOfBirth,
        'technician': technician,
      };

  /// Creates a new [UserModel] instance from a JSON format.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'].toString().toLowerCase(),
      // password: json['password'].toString(),
      fullName: json['fullName'],
      yearOfBirth: json['yearOfBirth'],
      technician: json['technician'],
    );
  }
}
