class UserModel {
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? profilePictureUrl;
  final String? userId;

  UserModel({
    required this.name,
    required this.email,
     this.phoneNumber,
     this.address,
     this.profilePictureUrl,
     this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
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
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'userId': userId,
    };
  }

  
}
