import 'package:car_loan_project/services/auth/auth_provider.dart';
import 'package:car_loan_project/services/auth/auth_user.dart';
import 'package:car_loan_project/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;
  AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  
  @override
  Future<AuthUser?> createUser({
    required String email, 
  required String passsword}) => provider.createUser(email: email,passsword: passsword,);
  
  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;
  
  @override
  Future<void> logOut() => provider.logOut();
  
  @override
  Future<AuthUser?> login({
    required String email, 
  required String passsword}) => provider.login(
    email: email, 
  passsword: passsword);

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
  
  @override
  Future<void> intialize() => provider.intialize();}