import 'dart:typed_data';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? bio;
  final Uint8List? image;
  final String? imgId;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    this.image,
    this.imgId,
  });
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
    Uint8List? image,
    String? imgId,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      image: image ?? this.image,
      imgId: imgId ?? this.imgId,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      bio: map['bio'],
      imgId: map['imgId'],
    );
  }
}
