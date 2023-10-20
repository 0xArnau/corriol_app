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
    this.technician = false,
  });

  /// The email address of the user.
  final String email;

  /// The full name of the user.
  final String fullName;

  /// Indicates whether the user is a technician or not.
  ///
  /// Default is `false`.
  final bool? technician;

  /// Converts the [UserModel] instance to a JSON format.
  Map<String, dynamic> toJson() => {
        'email': email.toLowerCase(),
        // 'password': password,
        'fullName': fullName,
        'technician': technician,
      };

  /// Creates a new [UserModel] instance from a JSON format.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'].toString().toLowerCase(),
      // password: json['password'].toString(),
      fullName: json['fullName'],
      technician: json['technician'],
    );
  }
}
