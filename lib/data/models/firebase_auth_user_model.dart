import 'package:lsm_project/domain/entities/auth_user.dart';

class FirebaseAuthUserModel {
  String email;
  String password;

  FirebaseAuthUserModel({
    required this.email,
    required this.password,
  });

  factory FirebaseAuthUserModel.fromJson(Map<String, dynamic> json) {
    return FirebaseAuthUserModel(
      email: json['email'],
      password: json['password'],
    );
  }

  AuthUser toEntity() {
    return AuthUser(
      email: email,
      password: password,
    );
  }
}
