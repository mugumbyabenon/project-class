import 'package:car_loan_project/services/auth/auth_user.dart';

abstract class AuthProvider{
  Future<void> intialize();
  AuthUser? get currentUser;
  Future<AuthUser?> login({
    required String email,
    required String passsword,
  });
  Future<AuthUser?> createUser({
    required String email,
    required String passsword,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}