import 'package:car_loan_project/services/auth/auth_user.dart';
import 'package:car_loan_project/services/auth/auth_provider.dart';
import 'package:car_loan_project/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth,FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';



class FirebaseAuthProvider implements AuthProvider{
  @override
  Future<AuthUser?> createUser({
    required String email, 
    required String passsword}) async {
    // TODO: implement createUser
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: passsword);
        final user = currentUser;
        if (user != null ){
          return user;
        } else {
          throw UserNotFoundAuthException();
        }
    }
    on FirebaseAuthException catch(e) {
      if (e.code=='weak-password'){
        throw WeakPasswordAuthException();
                } else if (e.code == 'email-already-in-use'){
                  throw EmailAlreadyinUseAuthException();
                } else if (e.code == 'invalid-email'){
                  throw InvalidEmailAuthException();
                }
                else {
                  throw GenericAuthException();
                }

    } catch(_){
        throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      return AuthUser.fromFirebase(user);
    }else {
      return null;
    }
  }
  
  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser?> login({required String email, required String passsword}) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
       password: passsword);  
       final user = currentUser; 
        if (user != null ){
          return user;
        } else {
          throw UserNotFoundAuthException();
        } 
    } on FirebaseAuthException catch (e){
                if (e.code == 'user-not-found'){
                  throw UserNotFoundAuthException();
                } else if (e.code =='wrong-password'){
                  throw WrongPasswordAuthException();
                  
                } else {
                  throw GenericAuthException();
                }
    
               } catch (_){
                throw GenericAuthException();
               
               }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
    
  }
  
  @override
  Future<void> intialize() async {
    await Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                );
  }

}