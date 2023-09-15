import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String profilePic;
  final String uid;
  final String token;
  UserModel({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.uid,
    required this.token,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? uid,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'profilePic': profilePic});
    result.addAll({'uid': uid});
    result.addAll({'token': token});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['_id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, profilePic: $profilePic, uid: $uid, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        token.hashCode;
  }
}
