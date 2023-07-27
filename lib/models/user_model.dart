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
    required this.age,
    this.technician = false,
  });

  /// The email address of the user.
  final String email;

  /// The full name of the user.
  final String fullName;

  /// The age of the user.
  final int age;

  /// Indicates whether the user is a technician or not. 
  /// 
  /// Default is `false`.
  final bool? technician;

  /// Converts the [UserModel] instance to a JSON format.
  Map<String, dynamic> toJson() => {
        'email': email,
        // 'password': password,
        'fullName': fullName,
        'age': age,
        'technician': technician,
      };

  /// Creates a new [UserModel] instance from a JSON format.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      // password: json['password'].toString(),
      fullName: json['fullName'],
      age: json['age'],
      technician: json['technician'],
    );
  }
}
