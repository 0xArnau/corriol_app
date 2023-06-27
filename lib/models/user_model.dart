class UserModel {
  UserModel({
    required this.email,
    // required this.password,
    required this.fullName,
    required this.age,
    this.technician = false,
  });

  final String email;
  // final String password;
  final String fullName;
  final int age;
  final bool? technician;

  Map<String, dynamic> toJson() => {
        'email': email,
        // 'password': password,
        'fullName': fullName,
        'age': age,
        'technician': technician,
      };

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
