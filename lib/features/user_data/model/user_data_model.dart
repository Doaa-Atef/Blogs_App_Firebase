class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? image;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      image: json['image'],
    );
  }
}
