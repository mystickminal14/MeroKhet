class Consumer {
  final String? uid;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String role;

  Consumer({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.role,
  });


  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'password': password,
      'role': role,
    };
  }
}
