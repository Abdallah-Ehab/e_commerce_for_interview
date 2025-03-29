class UserModel {
  String name;
  String email;
  String password; 
  String phoneNumber;
  String address;
  String profilePictureUrl;
  String userId;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.profilePictureUrl,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      profilePictureUrl: json['profilePictureUrl'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'userId': userId,
    };
  }
}
