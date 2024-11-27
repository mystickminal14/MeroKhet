class Farmer {
  final String? uid;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String role;
  final String farmAccountName;
  final String license;
  final String foodSafety;

  Farmer({
    this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.role,
    required this.farmAccountName,
    required this.license,
    required this.foodSafety,
  });

  // Converts the Farmer object to a Map (JSON format).
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'password': password,
      'role': role,
      'farmAccountName': farmAccountName,
      'license': license,
      'foodSafety': foodSafety,
    };
  }

}
